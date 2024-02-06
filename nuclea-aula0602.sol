/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
pragma solidity 0.8.19;

/// @author Jeff Prestes
/// @title Um exemplo de Faucet
contract Faucet {

    mapping(address=>uint8) public atribuicoes;
    uint8 valorASerAtribuido;

    // @notice Fornece a quem chamar a transacao um valor
    // @dev incrementa um no acumulador e atribuir o valor do acumulador a um endereco ethereum.
    // @return valor atual do acumulador
    function atribuirValor() public returns (uint256) {
        require(atribuicoes[msg.sender]==0, "Sinto muito. Voce ja teve sua chance");
        require(valorASerAtribuido < 256, "Sinto muito. Voce perdeu sua chance");
        valorASerAtribuido++;
        atribuicoes[msg.sender] = valorASerAtribuido;
        return valorASerAtribuido;
    }

}