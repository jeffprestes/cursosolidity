/*
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
pragma solidity 0.5.12;

contract Aluguel 
{
    string public locatario;
    string public locador;
    uint256 private valor;
    uint256 constant public numeroMaximoLegalDeAlgueisParaMulta = 3;
    bool[] public statusPagamento;
    address payable public contaLocatario;

    constructor(string memory nomeLocador, string memory nomeLocatario, address payable paramContaLocatario, uint256 valorDoAluguel) public 
    {
        locador = nomeLocador;
        locatario = nomeLocatario;
        valor = valorDoAluguel;
        contaLocatario = paramContaLocatario;
    }
 
    function valorAtualDoAluguel() public view returns (uint256) 
    {
        return valor;
    }
 
    function simulaMulta( uint256 mesesRestantes, uint256 totalMesesContrato) public view returns(uint256 valorMulta) 
    {
        valorMulta = valor*numeroMaximoLegalDeAlgueisParaMulta;
        valorMulta = valorMulta/totalMesesContrato;
        valorMulta = valorMulta*mesesRestantes;
        return valorMulta;
    } 
        
    function reajustaAluguel(uint256 percentualReajuste) public 
    {
        if (percentualReajuste > 20) 
        {
            percentualReajuste = 20;
        }
        uint256 valorDoAcrescimo = 0;
        valorDoAcrescimo = ((valor*percentualReajuste)/100);
        valor = valor + valorDoAcrescimo;
    }
    
    function aditamentoValorAluguel(uint256 valorCerto) public
    {
        valor = valorCerto;
    }

    function aplicaMulta(uint256 mesesRestantes, uint256 percentual) public
    {
        require(mesesRestantes<30, "Periodo de contrato inválido");
        for (uint i=1; i<mesesRestantes; i++) {
            valor = valor+((valor*percentual)/100);
        }
    }
    
    function receberPagamento() public payable {
        require(msg.value>=valor, "Valor insuficiente");
        contaLocatario.transfer(msg.value);
        statusPagamento.push(true);
    }
    
}
