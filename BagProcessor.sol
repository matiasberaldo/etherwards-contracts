// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Registry.sol";

contract BagProcessor {
    constructor() {

    }

    modifier restricted {
        _;
    }

    function attach(bytes[] calldata teamName, address bagAddress) external {

    }

    function distribute(Bag bag) external restricted {
        address bagAddress = bag.Address;
        Team team = register.findTeamOfBag(bagAddress);

        address[] members = team.MemberList;
        uint16 length = members.length;

        for(uint i = 0; i < length;) {
            extractValue(bagAddress, members[i]);

            unchecked {
                ++i;
            }
        }
    }

    function extractValue(address bagAddress, addess receiver) internal {
        uint amount = preprocessExtraction(bagAddress, receiver);

        Bag(bagAddress).release(receiver, amount); //assume it's the call is delegated from msg.sender through Interaction Intermediary, access verified
        register.updateClaimed(receiver);
    }

    function preprocessExtraction(address calldata bagAddress, address sender) internal returns (uint) {
        BagData data = register.requestBagData(bagAddress);
        ParticipantData participantData = register.requestDataFor(sender);

        /*uint16 supportedLength = data.SupportedAssets.length;

        for (uint i = 0; i < supportedLength;) 
        {


            unchecked {
                ++i;
            }
        };*/
        
        uint amount = IERC20(data.baseToken.balanceOf(bagAddress)) / participantData.Proportion;
        uint result = amount;

        if(data.donationProportion != 0) {
            uint reservedAmount = amount * data.donationProportion;

            result = amount - reservedAmount;
        }

        return result;
    }
}