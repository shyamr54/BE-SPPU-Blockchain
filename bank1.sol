// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract Bank {
    address public accHolder;
    uint256 balance = 0;

    constructor() {
        accHolder = msg.sender;
    }

    function withdraw() public {
        require(balance > 0, "You don't have enough balance");
        require(msg.sender == accHolder, "You are not the account holder.");
        payable(msg.sender).transfer(balance);
        balance = 0;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount should be greater than zero");
        require(msg.sender == accHolder, "You are not the account holder.");
        balance += msg.value;
    }

    function showBalance() public view returns (uint) {
        require(msg.sender == accHolder, "You are not the account holder.");
        return balance;
    }
}
