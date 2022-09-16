// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
//importing the require files from openzeppelin

contract Panther_eyes is ERC1155,Ownable {

   uint public constant violet_eye=0;
   uint public constant greenish_eye=1;
   uint public constant red_eye=2;
   uint public constant yellow_eye=3;

// assigning values to the each eyes
 
  constructor() ERC1155("https://ipfs.io/ipfs/bafybeiaa4za5xnkyl53v4twlh2auitfvunubejsdiv6rqwbh6lf322xu4i/{id}.JSON"){
// creating the IPFS URL and attaching the url to smart contract
      _mint(msg.sender,violet_eye,100,"");
      _mint(msg.sender,greenish_eye,100,"");
      _mint(msg.sender,red_eye,100,"");
      _mint(msg.sender,yellow_eye,100,"");
//minting each eye for 100 NFTs to the particular owner account .
  } 
}
