// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Crud {

    struct User {
        uint id;
        string name;
    }

    User[] public users;
    uint public nextId = 0;

    function create(string memory name) public {
        users.push(User(nextId, name));
        nextId++;
    }

    function read(uint id) public view returns (uint, string memory) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].id == id) {
                return (users[i].id, users[i].name);
            }
        }
        revert("User does not exist");
    }

    function update(uint id, string memory name) public {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].id == id) {
                users[i].name = name;
                return;
            }
        }
        revert("User does not exist");
    }

    function removeUser(uint id) public {
        uint index = find(id);
        if (index < users.length) {
            users[index] = users[users.length - 1];
            users.pop();
        } else {
            revert("User does not exist");
        }
    }

    function find(uint id) internal view returns (uint) {
        for (uint i = 0; i < users.length; i++) {
            if (users[i].id == id) {
                return i;
            }
        }
        revert("User does not exist");
    }
}
