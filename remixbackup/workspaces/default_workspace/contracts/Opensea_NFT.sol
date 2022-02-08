pragma solidity ^0.8.0;

//import ERC1155 token contract from openzeppelin

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";

//importing ownable.sol so only owner can mint nfts
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


//importing all the functionalities of ERC1155 using inheritance
contract NFTcontract is ERC1155, Ownable{

    //these are the id's of two diffrent NFT's
    uint256 public constant ARTWORK = 0;
    uint256 public constant PHOTO = 1;

    constructor() ERC1155("https://gif0txnvnfsk.usemoralis.com/{id}.json") {
        //minitng the nft's
        _mint(msg.sender, ARTWORK, 1, "");
        _mint(msg.sender, PHOTO, 2, "");
    }

    //as we cannot call _mint function directly from ERC1155 we are creating our own function which calls that function
    //so this would mint new nft to whatever account, id we specify
    function mint(address to, uint256 id, uint256 amount) public onlyOwner{
        //we are calling onlyOwner function because only owner should mint nfts
        _mint(to, id, amount, "");
    }

    function burn(address from, uint256 id, uint256 amount) public {
        require(msg.sender == from);
        _burn(from, id, amount);
    }
}
