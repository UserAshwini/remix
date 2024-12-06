//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

 contract SimpleStorage{

    // favoriteNumber gets initialized to 0 if no value is given
    uint256 myFavoriteNumber;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    // dynamic array
    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual{
        myFavoriteNumber = _favoriteNumber;
    }

    // view, pure
    function retrive() public view returns(uint256) {
        return myFavoriteNumber;
    }

    // memory, calldata, storage
    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        // Person memory newPerson = Person(_favoriteNumber,_name);
        listOfPeople.push( Person(_favoriteNumber,_name));
        nameToFavoriteNumber[_name]  = _favoriteNumber;
    }

    // function ex() internal{
    //     examplePrivate();
    // }

    // function examplePrivate() external{

    // }

 }