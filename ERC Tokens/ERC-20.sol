// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Web3 is ERC20, ERC20Burnable, Ownable {
    constructor()
        ERC20("Web3", "ERC20")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 10 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint amount) public onlyOwner{
        _burn(from, amount);
    }

    receive() external payable {}
}
