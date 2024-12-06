// Get Funds from User
// Withdraw Funds
// Set a minimum Funding value in USD

// SPDX-License-Identifier: MIT

error NotOwner();
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
     using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    modifier onlyOwner(){
        // require(msg.sender == i_owner,"Must be Owner!");
        if(msg.sender != i_owner) {revert NotOwner();}
        _;
    }

    function fund () public payable{
      require(msg.value.getConversionRate() >= MINIMUM_USD,"Didn't send enough ETH"); // 1e18 = 1 ETH = 1000000000 GWEI = 1000000000000000000 WEI  
      funders.push(msg.sender);
    //   addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        // for(/* starting index; ending index; step amount */)
        for(uint256 funderIndex = 0; funderIndex < funders.length ; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // msg.sender = address where payable(msg.sender) = payable address
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");
        // call
        (bool success,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call Failed");
    }

    receive() external payable{fund();}
    fallback() external payable{fund();}
}
