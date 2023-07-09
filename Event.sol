// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Event {
    string public name;
    string public externalUri;
    uint public maxParticipants;
    address public organizer;

    constructor(string memory _name, 
                string memory _externalUri,
                uint16 _maxParticipants) {
        
    }
}