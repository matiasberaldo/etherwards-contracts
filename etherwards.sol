// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Etherwards {
    struct Team {
        string name;
        address wallet_address;
        bool allowed;
    }

    struct Award {
        string name;
        string description;
        uint256 amount;
        uint256 quantity;
        bool paid;
        Team[] winners;
    }

    struct Sponsor {
        string name;
        address wallet_address;
        bool confirmed;
        Award[] awards;
    }

    struct Event {
        uint256 id;
        string name;
        string description;
        uint256 start_date;
        uint256 end_date;
        string location;
        address wallet_address;
        uint8 allowed_participants;
        Award[] awards;
        Sponsor[] sponsors;
    }

    mapping(address => Event[]) public events;
    mapping(address => mapping(uint256 => mapping(uint256 => Award))) public awards;

    event CreatedEvent(Event);
    event DeletedEvent(Event);

    function createEvent(Event memory _event) public {
        require(_event.wallet_address != address(0), "Cannot create an event with an empty wallet address");
        Award[] memory awards;
        Sponsor[] memory sponsors;

        events[msg.sender].push(Event(
            _event.id,
            _event.name,
            _event.description,
            _event.start_date,
            _event.end_date,
            _event.location,
            address(_event.wallet_address),
            _event.allowed_participants,
            awards,
            sponsors
        ));

        emit CreatedEvent(_event);
    }

    function deleteEvent(uint256 _id) public {
        for (uint256 i = 0; i < events[msg.sender].length; i++) {
            if (events[msg.sender][i].id == _id) {
                emit DeletedEvent(events[msg.sender][i]);
                delete events[msg.sender][i];
            }
        }
    }
}