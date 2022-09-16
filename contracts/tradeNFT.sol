//contracts/Panther_eyes_NFTs.sol
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract NftTrader{
    mapping(address => mapping(uint256=>Listing)) public listings;
// we are creating a mapping for address of user to the struct Listing 
    mapping(address => uint256) public balances;
//Each time the transaction is made the buyers are added to balances mapping 
    struct Listing{
        uint256 price;
        address seller;
    }
// used to check the price and seller 


    function Seller(uint256 price , address contractAddress , uint256 tokenId) public{
        ERC1155 token = ERC1155(contractAddress);
//used to communicate with the other smart contracts based on the contract address
        require(token.balanceOf(msg.sender,tokenId)>0,"caller must own given token");
  // the person calling this function to set the price should have the particular token in his account .
        require(token.isApprovedForAll(msg.sender,address(this)),"contract must be approved");
// used to make sure that the contract is approved by the owner in the ERC1155 smart contract.
        listings[contractAddress][tokenId]=Listing(price,msg.sender);
// after all the checks the sellers would set the price of the token and then it is added to the listing where the buyed could purchase based on the price.
    }

    function Buyer(address contractAddress , uint256 tokenId , uint256 amount) public payable{
// buyer need to mention the tokenId to buy particular NFT from the seller(owner)
        Listing memory item = listings[contractAddress][tokenId];
//variable for mentioning the mined contract address and particular tokenId of the NFT
        require(msg.value >= item.price* amount , "Insufficient funds sent");
//checking the funds of the buyer wheather it matches with the seller price limit
        balances[item.seller] += msg.value;
//once it is verified the balance is modified and added to seller
        ERC1155 token = ERC1155(contractAddress);
// connect with the minted token smart contract where the NFTs token balance is visible
        token.safeTransferFrom(item.seller,msg.sender,tokenId,amount,"");
//the NFT is transfer successfully to the buyer
    }
//extra functionality to transfer the money as per their mentioned address 


    function Withdraw(uint256 amount , address payable destAddress) public{
        require(amount <= balances[msg.sender] ,"Insufficient funds");
//check to verify the amount less then the balance of the sender
        destAddress.transfer(amount);
//transferring the amount to the destination address
        balances[msg.sender]-=amount;
//modifying the account balance of the sender

    }
}
