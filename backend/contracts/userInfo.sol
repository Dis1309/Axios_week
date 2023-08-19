//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract userInfo {
  
  struct user {
    string name;
    bytes32 password;
  }
   
   mapping (string => user) users;
  function setUser(string memory _name, string memory  _email, string memory _password) public {
    users[_email] = user(_name,keccak256(abi.encodePacked(_password)));
  }

  function getUser(string memory _email,string memory  _password) public view returns(string memory) {
    if(bytes(users[_email].name).length == 0) return "Non-existing user";
    else if(users[_email].password == keccak256(abi.encodePacked(_password))) return users[_email].name;
    else return "Incorrect password";
  }
}