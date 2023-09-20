// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "contracts/itaxa.sol";

contract EmprestimoComInterface {
    ITaxa taxa;

    constructor() {
        taxa = ITaxa(0xEed2fE736e53E65412A3c3b8326260218bD40c16);
    }

    function simulaEmprestimo(uint256 valor, uint256 risco) external view returns (uint256) {
        return valor*risco*taxa.taxaBase();
    }    
}
