// SPDX-License-Ide.ntifier: MIT
pragma solidity ^0.8.13;

import "experimental/Registry.sol";

contract BagFactory {
    enum BagType {
        EnablesContribution
    }

    Registry immutable registry;

    constructor(Registry _registry) {
        registry = _registry;
    }

    function create(BagType bagType) external returns (address) {
        Bag rewardBag = new Bag(bagType);

        return address(rewardBag);
    }
}