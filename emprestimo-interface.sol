// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./itaxa.sol";

contract EmprestimoComInterface {
    ITaxa taxa;

    constructor() {
        taxa = ITaxa(0x53958CAB8B8549970B2A8a63075D2FA2ea33c256);
    }

    function simulaEmprestimo(uint256 valor, uint256 risco) external view returns (uint256) {
        return valor*risco*taxa.taxaBase();
    }    
}
