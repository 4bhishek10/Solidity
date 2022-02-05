pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

contract StorageFactory{
    //array to store address of the simple storage contracts
    SimpleStorage[] public simpleStorageArray;

    //this function will call and store address of simple storage contract into array
    function createSimpleStorageContract() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    //now lets create function to interact with functions of other contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);  
    }

    //function to get the output data
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrive();
    }
}