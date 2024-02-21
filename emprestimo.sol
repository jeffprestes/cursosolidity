// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./taxa.sol";
import "./cadastro.sol";

contract EmprestimoComImport {

    Taxa taxa;
    Cadastro cadastro;

    constructor() {
        taxa = Taxa(0x53958CAB8B8549970B2A8a63075D2FA2ea33c256);
        cadastro = Cadastro(0xbFCA0dFfA6950A38B3Fd07641334f9392d73Fef0);
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
