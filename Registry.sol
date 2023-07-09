// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/endaoment/endaoment-contracts-v2/blob/main/src/Entity.sol";

contract Registry {
    struct Contribution {
        Entity Target;
        uint Proportion;
    }

    struct Bag {
        address Address;
        bool IsAttached;
    }

    struct Participant {
        string Name;
    }

    struct Team {
        string Name;
        uint16 Members;
        address Creator;
    }

    struct Event {
        string Name;
        address Organizer;
        address[] Sponsors;
        string ExternalURI;
    }

    mapping(address => Contribution) public bagContributions;
    mapping(address => Bag) public bagsByAddress;
    mapping(address => mapping(address => Bag)) public bagsByEventAddress;
    mapping(address => Team) public participantTeam;

    constructor() {

    }

    function setContributionTarget(Contribution calldata args) public {

    }
}