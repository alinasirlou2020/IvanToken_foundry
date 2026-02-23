// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Ivan_Token} from "../src/Ivan_Token.sol";
import {console} from "forge-std/console.sol";

contract DeployIvan is Script {
    function run() external returns (Ivan_Token) {
        // Retrieve private key from environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Start broadcasting transactions to the blockchain
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the contract with an initial supply of 1,000,000 IVN
        Ivan_Token ivanToken = new Ivan_Token(1000000);

        vm.stopBroadcast();

        // Print deployed address
        console.log("Ivan Token deployed at:", address(ivanToken));

        return ivanToken;
    }
}
