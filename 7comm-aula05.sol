// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Status {
    bool public isValid;
    constructor() {
        isValid = true;
    }
    function notValid() public returns(bool) {
        isValid = false;
        return true;
    }
}

contract Ownable {
    address public owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public onlyOwner returns (bool) {
        owner = _owner;
        return true;
    }
} 

contract LivroDeBordo is Ownable, Status {
    mapping(bytes32 => string) public ownerMessages;

    function saveMessage(string calldata _msg) external onlyOwner returns (bytes32) {
        ownerMessages[keccak256(bytes(string.concat(_msg, "teste")))] = _msg;
        return keccak256(bytes(_msg));
    }
}
