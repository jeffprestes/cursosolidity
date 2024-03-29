/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
/*
* "Commitar" fonte do contrato de aluguel no seu repositorio de fontes no Github com o nome de nuclea-aula05.sol
* Fazer deploy do contrato de aluguel na rede de teste Sepolia
* Realizar 2 pagamentos de aluguel
* Reajustar o aluguel em 7%
* Fazer dois pagamentos com o aluguel reajustado
* Voltar no fonte do contrato no seu repositório e adicionar um comentário com o endereço dele, exemplo: // Endereço do contrato na rede Sepolia 0x5042c9195ba56f6e6eee08255228b1da940258cf
*/
pragma solidity 0.8.19;

contract Aluguel {
    
    struct DadosPagamento {
        uint quandoFoiPago;
        uint valorPago;
    }
    
    string public locatario;
    string public locador;
    uint256 private valor;
    uint256 constant public numeroMaximoLegalDeAlugueisParaMulta = 3;
    DadosPagamento[] public statusPagamento;


    /*
    0 - 01/2020 = true
    1 - 02/2020 = true
    2 - 03/2020 = true
    3 - 04/2020 = true
    */
    address payable public contaLocador;
    address public owner;

    constructor(    string memory _nomeLocador, 
                    string memory _nomeLocatario, 
                    address payable _contaLocador, 
                    uint256 _valorDoAluguel)  payable {
        locador = _nomeLocador;
        locatario = _nomeLocatario;
        valor = _valorDoAluguel;
        contaLocador = _contaLocador;
        owner = msg.sender;
    }
 
    function valorAtualDoAluguel() public view returns (uint256) {
        return valor;
    }
 
    function simulaMulta( uint256 mesesRestantes, uint256 totalMesesContrato) public view returns(uint256 valorMulta) 
    {
        valorMulta = valor*numeroMaximoLegalDeAlugueisParaMulta;
        valorMulta = valorMulta/totalMesesContrato;
        valorMulta = valorMulta*mesesRestantes;
        return valorMulta;
    } 
        
    function reajustaAluguel(uint256 percentualReajuste) public {
        require(msg.sender == owner, "somente o dono do imovel pode reajustar o aluguel");
        if (percentualReajuste > 20) {
            percentualReajuste = 20;
        }
        uint256 valorDoAcrescimo = 0;
        valorDoAcrescimo = ((valor*percentualReajuste)/100);
        valor = valor + valorDoAcrescimo;
    }
    
    function aditamentoValorAluguel(uint256 valorCerto) public   {
        valor = valorCerto;
    }

    function aplicaMulta(uint256 mesesRestantes, uint256 percentual) public     {
        require(mesesRestantes<30, "Periodo de contrato invalido");
        for (uint numeroDeVoltas=0; numeroDeVoltas < mesesRestantes; numeroDeVoltas=numeroDeVoltas+2) {
            valor = valor+((valor*percentual)/100);
        }
    }
    
    
    function receberPagamento() public payable {        
        require(msg.value>=valor, "Valor insuficiente");
        contaLocador.transfer(msg.value);
        DadosPagamento memory dPgto = DadosPagamento(block.timestamp, msg.value);
        statusPagamento.push(dPgto);
    }
    
    //msg.value = valor em wei enviado ao contrato
    
    function retornaTexto(uint256 _parametro) public view returns (string memory) {
        if ((valor * _parametro) > 5000) {
            return "Muito caro";
        } else {
            return "Preco razoavel";
        }
    }
    
    function quantosPagamentosJaForamFeitos() public view returns (uint256) {
        return statusPagamento.length;
    }

    function historicoDePagto() public view returns (uint valorTotalRecebido, uint numAluguelRecebido) {
        for (uint256 i; i < statusPagamento.length; i++) {
            valorTotalRecebido += statusPagamento[i].valorPago;
            numAluguelRecebido++;
        }
        return (valorTotalRecebido, numAluguelRecebido);
    }
}