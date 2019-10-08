/*
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
pragma solidity 0.5.12;

contract Aluguel 
{
    string            public                       locatario;
    string public locador;
    uint256 private valor;

    constructor(string memory nomeLocador, string memory nomeLocatario, uint256 valorDoAluguel) public 
    {
        locador = nomeLocador;
        locatario = nomeLocatario;
        valor = valorDoAluguel;
    }
 
    function valorAtualDoAluguel() public view returns (uint256) 
    {
        return valor;
    }
 
    function simulaMulta( uint256 mesesRestantes, uint256 totalMesesContato) public view returns(uint256 valorMulta) 
    {
        valorMulta = valor*numeroMaximoLegalDeAlgueisParaMulta;
        valorMulta = valorMulta/totalMesesContato;
        valorMulta = valorMulta*mesesRestantes;
        return valorMulta;
    } 
        
    function reajustaAluguel(uint256 percentualReajuste) public 
    {
        uint256 valorDoAcrescimo = 0;
        valorDoAcrescimo = ((valor*percentualReajuste)/100);
        valor = valor + valorDoAcrescimo;
    }
}
