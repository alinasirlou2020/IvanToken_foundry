// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Ivan_Token} from "../src/Ivan_Token.sol";
import {DeployIvan} from "../script/DeployIvan.s.sol";

contract IvanTokenTest is Test {
    Ivan_Token public ivanToken;
    DeployIvan public deployer;

    address public user = makeAddr("user");
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        // Mocking the environment variable for testing purposes
        // This prevents the "Environment variable not found" error during local forge test
        vm.setEnv("PRIVATE_KEY", vm.toString(uint256(keccak256("test_key"))));

        deployer = new DeployIvan();
        ivanToken = deployer.run();
    }

    function testInitialSupply() public view {
        // Initial supply: 1,000,000 * 10^18
        assertEq(ivanToken.totalSupply(), 1000000 * 10 ** 18);
    }

    function testTransfer() public {
        uint256 amount = 1000 * 10 ** 18;
        address owner = ivanToken.owner();

        // Transfer from owner to user
        vm.prank(owner);
        bool success = ivanToken.transfer(user, amount);

        assertTrue(success, "Transfer failed");
        assertEq(ivanToken.balanceOf(user), amount);
        assertEq(ivanToken.balanceOf(owner), (1000000 * 10 ** 18) - amount);
    }

    function testMintByOwner() public {
        uint256 mintAmount = 500 ether;
        address owner = ivanToken.owner();

        vm.startPrank(owner);
        ivanToken.mint(user, mintAmount);
        vm.stopPrank();

        assertEq(ivanToken.balanceOf(user), mintAmount);
    }

    function test_RevertWhen_NonOwnerMints() public {
        uint256 mintAmount = 500 ether;

        // Ensure the transaction reverts when a non-owner tries to mint
        vm.expectRevert();

        vm.prank(user);
        ivanToken.mint(user, mintAmount);
    }
}
