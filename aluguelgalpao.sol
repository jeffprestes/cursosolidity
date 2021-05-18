// SPDX-License-Identifier: CC-BY-4.0
pragma solidity 0.8.4;

contract AluguelDeGalpao {
    string public locatario;
    string locador;
    uint public valorAluguel;
    uint constant numeroMaximoMesesParaMulta = 3;
    uint constant percentualMaximoDeReajuste = 10;
    
    constructor() {
        locatario = "Josefa";
        locador = "Mariana";
        valorAluguel = 1200;
    }
    
    function obtemNomeLocador() public view returns (string memory) {
        return locador;
    }
    
    function definirNovoValorAluguel(uint novoValorAluguel) public {
        valorAluguel = novoValorAluguel;
    }
    
    function verificaSePercentualDeReajusteEValido(uint percentualAlmejado) 
    public
    pure
    returns (bool resposta) {
        if (percentualAlmejado <= percentualMaximoDeReajuste) {
            return true;
        } else {
            return false;
        }
    }
    
    function simularReajusteComposto(uint mesesRestantes, uint percentualAlmejado) 
    public
    view
    returns (uint possivelNovoValor) {
        possivelNovoValor = valorAluguel;
        
        for(uint mesesAcumulados = 1; mesesAcumulados <= mesesRestantes; mesesAcumulados = mesesAcumulados+1) {
//                                           1        <=       10   
//                                           2        <=       10
//                                           11       <=       10
            possivelNovoValor = possivelNovoValor + (possivelNovoValor*percentualAlmejado)/100;
//               1100        <--    1000     + (    1000    *      10          )/100
//               1211        <--    1100     + (    1100    *      10          )/100
        }
        
        return possivelNovoValor;
    }
}
