// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Ivan Token
 * @dev Implementation of the Ivan Token (IVN) using OpenZeppelin standards.
 * This contract demonstrates ERC20 deployment and minting logic.
 */
contract Ivan_Token is ERC20, Ownable {
    // Constructor mints initial supply to the deployer
    constructor(uint256 initialSupply) ERC20("Ivan", "IVN") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    /**
     * @dev Function to mint new tokens, restricted to the owner.
     * @param to The address that will receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
