// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract MyContract{

    uint public myUint = 123;

    function setMyUint(uint _newUint) public {
        myUint = _newUint;
    }
}