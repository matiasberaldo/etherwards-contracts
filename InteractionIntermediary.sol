// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Registry.sol";

contract InteractionIntermediary {
    constructor() {

    }

    modifier organizer {
        _;
    }

    modifier finalized {
        _;
    }

    modifier unprocessed {
        _;
    }

    modifier attached(address bagAddress) {
        Bag data = register.requestBagData(bagAddress);

        require(data.IsAttached);
        _;
    }

    function release() public organizer finalized unprocessed {
        Bag[] bags = register.getBagListForEvent(eventAddress);
        uint16 length = bags.length;
        bool bagProcessingDelegated = true;

        for(uint i = 0; i < length;) {
            if(bagProcessingDelegated) {
                BagProcessor.distribute(bags[i]);
            }

            unchecked {
                ++i;
            }
        }
    }
}