// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

contract Web3 is ERC1155, Ownable, ERC1155Pausable, ERC1155Supply, PaymentSplitter {
    uint256 public publicPrice = 0.02 ether;
    uint256 public allowListPrice = 0.01 ether;
    uint256 maxSupply = 1;
    uint constant public maxPurchasePerWallet = 3;

    bool public publicMintOpen = false;
    bool public allowListMintOpen = true;

    // HERE WE HAVE ADDED PAYMENT SPLITTER.
    // IT SPLITS BETWEEN THE ADDRESS(_payees) FOR SHARES(_shares).
    // WE WILL ADD THIS DURING DEPLOYMENT address_array and shares_array 
    constructor(address[] memory _payees, uint[] memory _shares)
        ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
        Ownable(msg.sender)
        PaymentSplitter(_payees,_shares)
    {}

    mapping(address => bool) public allowListAddress;
    mapping(address => uint) public purchasePerWallet;

    modifier MintFuntion(
        uint256 id,
        uint256 amount,
        uint256 price
    ) {
        require(purchasePerWallet[msg.sender] + amount <= maxPurchasePerWallet, "MAX LIMIT PER WALLET REACHED");
        require(msg.value == (amount * price), "NOT ENOUGH MONEY SENT!!!");
        require(totalSupply(id) + amount <= maxSupply, "SORRY! WE MINTED OUT.");
        require(id < 5, "YOU ARE TRYING TO MINT WRONG NFTs");
        _;
    }

    modifier windowStatus(bool _status) {
        require(_status, "Window is closed!!!");
        _;
    }


    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // THE 'amount' REFERS TO TOTAL NO. OF NFTs TO BE MINTED.
    // PUBLIC MINTING FUNCTION
    function publicMint(uint256 id, uint256 amount)
        public
        payable
        windowStatus(publicMintOpen)
        MintFuntion(id, amount, publicPrice)
    {
        _mint(msg.sender, id, amount, "");
    }


    // ALLOWLIST MINTING FUNCTION
    function allowListMint(
        address _address,
        uint256 id,
        uint256 amount
    ) public payable windowStatus(allowListMintOpen) MintFuntion(id, amount, allowListPrice){
        require(
            allowListAddress[_address],
            "You are not allowed for minting!!!"
        );
        _mint(msg.sender, id, amount, "");
    }

    // FUNCTION TO SET ALLOW LIST ADDRESSES
    function setAllowList(address[] memory addresses) external  onlyOwner{
        for(uint i=0;i<addresses.length;i++){
            allowListAddress[addresses[i]] = true;
        }
    }

    // SETTING MINTING WINDOW FOR MINTING
    function mintingWindow(bool _publicMint, bool _allowListMint)
        external
        onlyOwner
    {
        publicMintOpen = _publicMint;
        allowListMintOpen = _allowListMint;
    }

    // CREATING URI/IPFS FOR OUR NFTS TO SEE ON OPENSEA
    function uri(uint256 _id)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(exists(_id), "URI : NOT EXIST");
        return
            string(
                abi.encodePacked(super.uri(_id), Strings.toString(_id), ".json")
            );
    }

    // WITHDRAWING THE MONEY FROM SMART CONTRACT
    function withDrawMoney(address _address) external onlyOwner {
        uint256 balance = address(this).balance;
        payable(_address).transfer(balance);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal override(ERC1155, ERC1155Pausable, ERC1155Supply) {
        super._update(from, to, ids, values);
    }
}
