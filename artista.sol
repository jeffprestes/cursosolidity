pragma solidity 0.5.12;

contract MichelTelo {
    
    address payable public michelTelo;
    address payable public advogado;
    address public produtora;
    uint public valorDoContrato;
    uint public dataDeVencimento;
    uint public indiceMulta;
    uint public percentualMichelTelo;
    uint public valorDevidoMichelTelo;
    bool public pago;
    bool public retirado;
    
    event pagamentoRealizado (uint valor);
    
    modifier autorizadosRecebimento () {
        require (msg.sender == michelTelo || msg.sender == advogado, "Operaçao exclusiva do contratado.");
        _;    
    }
    
    modifier somenteProdutora () {
        require (msg.sender == produtora, "Operaçao exclusiva do contratante.");
        _;
    }
    
    constructor(
        address payable _michelTelo,
        address _produtora,
        uint _valorDoContrato,
        uint _dataDePagamento,
        uint _percentualMichelTelo
    ) public {
        michelTelo = _michelTelo;
        advogado = msg.sender;
        produtora = _produtora;
        valorDoContrato = _valorDoContrato;
        dataDeVencimento = now+_dataDePagamento;
        percentualMichelTelo = _percentualMichelTelo;
        indiceMulta = 5;
    }
    
    function saldoNoContrato () public view returns (uint) {
        return address(this).balance;
    }
    
    function simulacaoDoValorDaMulta (uint dataDePagamentoSimulado) public view returns (uint valorSimuladoMulta) {
        uint prazoEmAtraso = dataDePagamentoSimulado - dataDeVencimento;
        uint diaEmSegundos = 86400;
        //Para o caso de atraso menor que um dia
        if (prazoEmAtraso < diaEmSegundos) {
            valorSimuladoMulta = (valorDoContrato*indiceMulta);
            valorSimuladoMulta = (valorSimuladoMulta/100);
            return valorSimuladoMulta;
        }
        uint diasMulta = (prazoEmAtraso/diaEmSegundos)+1;
        valorSimuladoMulta = (valorDoContrato*(indiceMulta*diasMulta));
        valorSimuladoMulta = (valorSimuladoMulta/100);
        return valorSimuladoMulta;
    }
    
    function calculoMulta () public view returns (uint valorMulta) {
        return simulacaoDoValorDaMulta(now);
    }
    
    function soma(uint a, uint b) public pure returns (uint resultado) {
        resultado = (((a + b)*1000)/100);
        return resultado;
    }
    
    function pagamentoNoPrazo () public payable somenteProdutora {
        require (now <= dataDeVencimento, "Devedor em mora.");
        require (msg.value == valorDoContrato, "Valor diverso do devido");
        pago = true;
        emit pagamentoRealizado(msg.value);
    }
    
    function pagamentoEmMora() public payable somenteProdutora {
        require (now > dataDeVencimento, "Mora não constituida.");
        require (!pago, "Pagamento já realizado.");
        require (msg.value == (simulacaoDoValorDaMulta(now) + valorDoContrato), "Valor diverso do devido.");
        pago = true;
        emit pagamentoRealizado(msg.value);
    }
    
     function distribuicaoDeValores() public autorizadosRecebimento {
        require(pago, "Pagamento não realizado");
        // é algo a linha acima require(pago == true, "Pagamento não realizado");
        require(retirado == false, "Distribuição já realizada.");
        
        valorDevidoMichelTelo = (percentualMichelTelo * address(this).balance)/100;
        
        michelTelo.transfer(valorDevidoMichelTelo);
        advogado.transfer(address(this).balance);
        // advogado.transfer(100);
        // 100 wei sao transferidos para a carteira do advogado
        retirado = true;
    }
}
