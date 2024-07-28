// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;  // Updated to a more specific version within the range

contract Banking {

    mapping(address => uint) public userAccount;
    mapping(address => bool) public userExists;

    // Function to create an account
    function createAcc() public payable returns (string memory) {
        require(!userExists[msg.sender], "Account already created");

        if (msg.value == 0) {
            // Initialize account with zero balance if no funds are sent
            userAccount[msg.sender] = 0;
        } else {
            // Initialize account with the sent amount if funds are sent
            userAccount[msg.sender] = msg.value;
        }

        userExists[msg.sender] = true;
        return "Account created";
    }

    // Function to deposit funds into the account
    function deposit() public payable returns (string memory) {
        require(userExists[msg.sender], "Account is not created");
        require(msg.value > 0, "Deposit value must be greater than zero");

        userAccount[msg.sender] += msg.value;
        return "Deposited successfully";
    }

    // Function to withdraw funds from the account
    function withdraw(uint amount) public returns (string memory) {
        require(userExists[msg.sender], "Account is not created");
        require(userAccount[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Withdrawal amount must be greater than zero");

        userAccount[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}(""); // Use call to avoid reentrancy issues
        require(success, "Transfer failed");

        return "Withdrawal successful";
    }
}
