/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/

pragma solidity 0.8.4;

/// @title Manages the contract owner
contract Owned {
    address payable contractOwner;

    constructor() { 
        contractOwner = payable(msg.sender); 
    }
    
    function whoIsTheOwner() public view returns(address) {
        return contractOwner;
    }
}

/// @title Mortal allows the owner to kill the contract
contract Mortal is Owned  {
    function kill() public {
        require(msg.sender==contractOwner, "Only owner can destroy the contract");
        selfdestruct(contractOwner);
    }
}


contract Sale is Mortal {
    
    uint public basePrice;
    
    function changeTokenBasePrice(uint _basePrice) public {
        require(msg.sender==contractOwner, "Only owner can change base token price");
        basePrice = _basePrice;
    }
    
}
