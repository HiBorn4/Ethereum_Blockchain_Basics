// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract A {
    event MyEvent(string _myString);
    function funA() public virtual {
        emit MyEvent("from A");
    }
}

contract B {
    function funA() public virtual {
        //does nothing
    }
}

contract C is A,B {
    function funA() public override(B,A) {
        emit MyEvent("from B");
        super.funA();
    }
}