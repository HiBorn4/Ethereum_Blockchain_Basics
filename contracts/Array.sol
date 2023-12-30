// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract MyContract {
    uint[] public myUintArray;
    
    function add(uint _num) public {
        myUintArray.push(_num);
    }
    
    function removeElement() public {
        myUintArray.pop();
    }
}