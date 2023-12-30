// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

// Wallet has 1 Owner
// Receive funds with a fallback function
// Spend money on EOA and Contracts
// Give Allowance to other people
// Set a new owner with 3 out of 5 guardians

contract Consumer {
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    function deposit() public payable {}
}

contract SmartWallet {

    address payable public owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;
    mapping(address => bool) public guardians;
    address payable nextOwner;
    uint guardiansResetCount;
    uint public constant confirmationFromGuardiansForReset = 3;
    mapping(address => mapping(address => bool)) nextOwnerGuardianVotedBool;

    constructor(){
        owner = payable(msg.sender);
    }

    function setGuardians(address _guardian, bool _isGuardian) public {
        require(msg.sender == owner, "You are not the Owner, Aborting!");
        guardians[_guardian] = _isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender], "You are not a Guardian Of This Wallet, Aborting!");
        require(nextOwnerGuardianVotedBool[_newOwner][msg.sender] == false, "You already voted, Aborting!");
        if(_newOwner != nextOwner){
            nextOwner = _newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;

        if(guardiansResetCount >= confirmationFromGuardiansForReset){
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

    function setAllowance(address _for, uint _amount) public {
        
        require(msg.sender == owner, "You are not the Owner, Aborting!");
        
        allowance[_for] = _amount;

        if (_amount > 0) {
            isAllowedToSend[_for] = true;
        }
        else {
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns (bytes memory){
        
        // require (msg.sender == owner, "You are not the Owner, Aborting!");

        if(msg.sender != owner) {
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, Aborting!");
            require(isAllowedToSend[msg.sender], "You are not allowed to send anything from this smart contract, Aborting!");
            allowance[msg.sender] -= _amount;
        }
        
        (bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
        
        require(success, "Aborting, Call was not Successful");
        
        
        // _to.transfer(_amount);
        return returnData;  
    } 

    receive() external payable { }

}