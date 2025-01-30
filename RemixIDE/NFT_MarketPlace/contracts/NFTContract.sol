// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title This is a basic smart contract for NFT marketplace to Mint,Buy,Sell,List NFTs
 * @author anurag shingare
 * @notice This smart contract includes the functions to Mint,Buy,Sell,List,Transfer the ownership of NFTs
 * @dev The basic workflow of NFT marketplace is:
    a. The NFT owner will mint new NFT by providing NFT metadata.
    b. We will store the owner information
    c. NFT owner can list the owned NFT on marketplace for sell.
    d. Other users can buy the NFT which are on sale.
    e. Ownership will transfer from seller to buyer!!!
    f. And, the process continues
    g. For,further improvement we will take the input of nft metadata from frontend!!!
*/

contract NFTContract is ERC721, Ownable {
    // errors
    error NFTContract_NotEnoughMoneySentToBuyNFT();
    error NFTContract_ExtraMoneySentTryAgain();
    error NFTContract_OwnerOfNftCannotBuyOwnedNftAgain();
    error NFTContract_TransactionFailed();
    error NFTContract_YouAreNotOwnerOfNft();

    // type declaration
    enum NFTSellingState {
        NotOnSell,
        OnSell,
        Sold
    }

    struct NFTsOnSell {
        uint256 tokenId;
        address nftOwner;
        NFTSellingState nftSellingState;
        uint256 nftPrice;
    }

    struct NFTOwner {
        uint256 id;
        uint256 _tokenId;
        string _tokenUri;
        NFTSellingState _nftSellingstate;
        uint256 _nftPrice;
        address nftOwner;
    }

    mapping(address => NFTOwner[]) public s_nftOwner;
    NFTsOnSell[] public s_nftOnSell;

    // State Variables
    uint256 public s_tokenId;
    string private constant s_tokenUri =
        "ipfs://bafybeigrrzrsqcedeqzf3xlodqg2agicgk5f7eibgydojvvapjkct6ixcq";

    // events
    event NFTContract_NewNFTMinted(
        address _to,
        uint256 _tokenId,
        string _tokenUri,
        NFTSellingState _sellingState
    );
    event NFTContract_NFTSetForSell(
        uint256 tokenId,
        address owner,
        NFTSellingState nftSellingState,
        uint256 nftPrice
    );
    event NFTContract_SuccessfullyBuyedTheNFT(
        address _from,
        address _to,
        uint256 _tokenId,
        uint256 _price
    );
    event NFTContract_NftTransfered(
        address nftOwner,
        address to,
        uint256 nftPrice,
        NFTSellingState nftSellingState
    );

    // functions
    constructor() ERC721("Web3Developers", "WEB3") Ownable(msg.sender) {
        s_tokenId = 0;
    }

    /**
     * @dev ERC-721 (Minting function)
     * This function will allow owner to mint the new nft
        a. Specify the tokenUri
        b. NFT details will be stored in an array
        c. This will store all the NFTs owned by the owner in an array.
        d. After, minting the NFTSelling state will be NotOnSell
        e. And, after owner transfership/buying NFT the state will be changed to Sold.
     */
    function mintNFT(string memory _tokenUri) public {
        uint256 _tokenId = s_tokenId;
        // creating new instance of NFTOwner
        NFTOwner memory newNFTOwner = NFTOwner({
            id: s_nftOwner[msg.sender].length,
            _tokenId: _tokenId,
            _tokenUri: _tokenUri,
            _nftSellingstate: NFTSellingState.NotOnSell,
            _nftPrice: 0 ether,
            nftOwner: msg.sender
        });
        s_nftOwner[msg.sender].push(newNFTOwner);
        _safeMint(msg.sender, s_tokenId);
        s_tokenId++;
        setApprovalForAll(address(this), true);
        emit NFTContract_NewNFTMinted(
            msg.sender,
            _tokenId,
            _tokenUri,
            NFTSellingState.NotOnSell
        );

    }

    /** 
        @dev ERC-721 (listing function)
        * This function will update NFT state for sell
        * The NFT will be listed on marketplace page.
        * This will update the nft on sale state as OnSell.
        * Set the desire price of NFT.
     */
    function setNFTOnSell(uint256 _id, uint256 setNftPrice) public {
        if (_ownerOf(s_nftOwner[msg.sender][_id]._tokenId) != msg.sender) {
            revert NFTContract_YouAreNotOwnerOfNft();
        }

        // change the nft state
        s_nftOwner[msg.sender][_id]._nftSellingstate = NFTSellingState.OnSell;
        NFTsOnSell memory newNftForSell = NFTsOnSell({
            tokenId: s_nftOwner[msg.sender][_id]._tokenId,
            nftOwner: msg.sender,
            nftSellingState: NFTSellingState.OnSell,
            nftPrice: setNftPrice
        });
        s_nftOnSell.push(newNftForSell);

        emit NFTContract_NFTSetForSell(
            s_nftOwner[msg.sender][_id]._tokenId,
            msg.sender,
            NFTSellingState.OnSell,
            setNftPrice
        );  
    }

    /** 
        @dev ERC-721 (Buying function)
        * Other, users can buy the listed NFTs for given price
        * We will transfer ownership of nft from seller to buyer.
        * The state will changed to notOnSell->onSell->sold->NotOnSell
    */
    function buyListedNft(uint256 _id) public payable {
        if (msg.value < s_nftOnSell[_id].nftPrice) {
            revert NFTContract_NotEnoughMoneySentToBuyNFT();
        }
        if (msg.value > s_nftOnSell[_id].nftPrice) {
            revert NFTContract_ExtraMoneySentTryAgain();
        }
        if (msg.sender == s_nftOnSell[_id].nftOwner) {
            revert NFTContract_OwnerOfNftCannotBuyOwnedNftAgain();
        }

        // Verify that the contract is approved to transfer the NFT
        require(
            isApprovedForAll(s_nftOnSell[_id].nftOwner, address(this)),
            "Contract is not approved to transfer this NFT"
        );

        s_nftOnSell[_id].nftSellingState = NFTSellingState.Sold;
        s_nftOwner[msg.sender].push(
            NFTOwner({
                id: s_nftOwner[msg.sender].length,
                _tokenId: s_nftOnSell[_id].tokenId,
                _tokenUri: "",
                _nftSellingstate: NFTSellingState.NotOnSell,
                _nftPrice: 0 ether,
                nftOwner: msg.sender
            })
        );
        (bool success, ) = payable(s_nftOnSell[_id].nftOwner).call{
            value: s_nftOnSell[_id].nftPrice
        }("");

        if (!success) {
            revert NFTContract_TransactionFailed();
        }
        safeTransferFrom(
            s_nftOnSell[_id].nftOwner,
            msg.sender,
            s_nftOnSell[_id].tokenId
        );
        emit NFTContract_NftTransfered(
            s_nftOnSell[_id].nftOwner,
            msg.sender,
            s_nftOnSell[_id].nftPrice,
            s_nftOnSell[_id].nftSellingState
        );
    }

    function getNFTOwnedInfo(address _ownerAddress)
        public
        view
        returns (NFTOwner[] memory)
    {
        return s_nftOwner[_ownerAddress];
    }

    function getNFTOwner(uint256 _tokenId) public view returns (address) {
        return _ownerOf(_tokenId);
    }
}
