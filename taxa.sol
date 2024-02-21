// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./itaxa.sol";

contract Taxa is ITaxa {
    uint256 public taxaBase = 1;
    
    function setTaxaBase(uint256 _novaTaxaBase) public returns (uint256) {
        taxaBase = _novaTaxaBase;
        return taxaBase;
    }
}
