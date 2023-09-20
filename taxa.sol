// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "contracts/taxa.sol";
import "contracts/cadastro.sol";

contract EmprestimoComImport {

    Taxa taxa;
    Cadastro cadastro;

    constructor() {
        taxa = Taxa(0xEed2fE736e53E65412A3c3b8326260218bD40c16);
        cadastro = Cadastro(0xF5d7882fC5248efC814Adc765fAb168DE45c3536);
    }

    function simulaEmprestimo(uint256 valor, uint256 _idCliente) external view returns (uint256) {
        (Cadastro.Cliente memory cliente, bool existe) = cadastro.getClientePeloId(_idCliente);
        require(existe, "cliente nao existe na base");
        uint256 risco = cliente.id;
        return valor*risco*taxa.taxaBase();
    }

    function ajustaTaxa(uint256 _novaTaxa) external returns (bool) {
        taxa.setTaxaBase(_novaTaxa);
        return true;
    }

}
