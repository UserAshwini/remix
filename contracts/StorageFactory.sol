// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{

    // SimpleStorage public simpleStorage;
    SimpleStorage[] public listOfSimpleStorageContract;

    function createSimpleStorageContract() public{
        // simpleStorage = new SimpleStorage();
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContract.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // Address and ABI - Application Binary Interface
        SimpleStorage mySimpleStorage = listOfSimpleStorageContract[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);


    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        // SimpleStorage mySimpleStorage =  listOfSimpleStorageContract[_simpleStorageIndex];
        return listOfSimpleStorageContract[_simpleStorageIndex].retrive();
    }
}