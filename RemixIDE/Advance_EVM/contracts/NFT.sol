// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";


/**
 * @title Developing Dynamic NFTs collection using smart contract
 * @author anurag shingare
 * @notice This smart contract deploy Dynamic NFTs on sepolia/anvil using smart contract by providing the tokenURI(NFT metadata)
 * @dev This smart contract includes:
        a. mintDynamicNft() that will mint our NFT
        b. DynamicallyFlipNFT() will flip the image of our NFT on the base of state.
        c. _baseURI() is the token and Image URI starting endpoint (data:application/json;base64,)
        d. DynaminTokenURI() this will return the tokenURI/NFT metadata
        e. We are converting our NFT metadata into base64 format into TokenURI
        

 * @dev We are storing our NFT metadata and ImageURI on-chain
        Our image svg is converted into base64 format

 * @dev TokenId and deployed contract address is Imp. to import our NFT on metamask
*/


contract DynamicNFTs is ERC721, Ownable {
    // errors
    error DynamicNFTs_YouAreNotOwnerOfThisNFT();

    // type declaration
    enum NFTState {
        Happy,
        Bad
    }

    mapping(uint => NFTState) public s_NFTState;

    // state varaibles
    uint256 private s_tokenId;
    // data:image/svg+xml;base64,URI
    string private s_HappyMonkeyImageURI;
    string private s_BadMonkeyImageURI;

    // events
    event DynamicNFTs_NFTCreated(uint256 tokenId);

    // functions
    constructor(
        string memory happyMonkeyImageUri,
        string memory badMonkeyImageUri
    ) ERC721("DynamicMonkeys", "DMNK") Ownable(msg.sender) {
        s_tokenId = 0;
        s_HappyMonkeyImageURI = happyMonkeyImageUri;
        s_BadMonkeyImageURI = badMonkeyImageUri;
    }

    function mintDynamicNft() public {
        uint256 tokenId = s_tokenId; 
        _safeMint(msg.sender, tokenId);
        s_tokenId++; 
        emit DynamicNFTs_NFTCreated(tokenId);
    }

    function DynamicallyFlipNFT(uint256 _tokenId) public onlyOwner {
        if (s_NFTState[_tokenId] == NFTState.Happy) {
            s_NFTState[_tokenId] = NFTState.Bad;
        } else {
            s_NFTState[_tokenId] = NFTState.Happy;
        }
    }

    // data:application/json;base64,
    // data:image/svg+xml;base64,
    function _baseURI() internal view override returns (string memory) {
        return "data:application/json;base64,";
    }

    function DynaminTokenURI(
        uint256 _tokenId
    ) public returns (string memory) {
        string memory s_name = name();
        string memory s_baseuri = _baseURI();
        string memory s_imageuri;

        if (s_NFTState[_tokenId] == NFTState.Bad) {
            s_NFTState[_tokenId] = NFTState.Happy;
            s_imageuri = s_HappyMonkeyImageURI;
        } else {
            s_imageuri = s_BadMonkeyImageURI;
            s_NFTState[_tokenId] = NFTState.Bad;
        }

        // Create the JSON string dynamically
        string memory tokenMetadata = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            "{",
                            '"name":"',
                            s_name,
                            '",',
                            '"description":"NFTs collection of moodies monkeys!",',
                            '"image":"',
                            s_imageuri,
                            '",',
                            '"attributes":[{',
                            '"trait_type":"mood",',
                            '"value":"moodies"',
                            "}]",
                            "}"
                        )
                    )
                )
            )
        );
        return tokenMetadata;
    }

    function getNFTState(uint256 _tokenId) public view returns(NFTState){
        return s_NFTState[_tokenId];
    }
}
