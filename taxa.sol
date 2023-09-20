// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Mumbai: 0xEed2fE736e53E65412A3c3b8326260218bD40c16
contract Taxa {
    uint256 public taxaBase = 1;
    
    function setTaxaBase(uint256 _novaTaxaBase) public returns (uint256) {
        taxaBase = _novaTaxaBase;
        return taxaBase;
    }
}
