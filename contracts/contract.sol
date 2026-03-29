// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract SupplyChainProvenance {
    enum actorRole {
        None,
        Supplier,
        Manufacturer,
        Distributor,
        Retailer,
        Regulator,
        Consumer
    }
    struct itemStatus {
        // dont know if we should use a enum here
        string status;
    }
    struct actor {
        actorRole role;
        bool exists;
    }
    struct signature {
        address signer;
        actorRole role;
        uint256 timestamp;
        string note;
    }
    struct item {
        uint256 id;
        string itemName;
        string metadata;
        address creator;
        itemStatus status;
        bool exists;
    }
    }