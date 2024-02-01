// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract CadastroClientes {
    mapping(address => Conta) public clientes;
    uint public totalDeContas;

    struct Conta {
        string nomeCliente;
        address enderecoCliente;
        uint saldo;
        bool status;
    }

    modifier somenteContaAberta(address _enderecoCliente) {        
        require(clientes[_enderecoCliente].status, "conta nao existente ou fechada");
        _;
    }

    function abreConta(
        string memory _nomeCliente,
        address _enderecoCliente, 
        uint _depositoInicial) 
    external returns(bool) {
        require(_depositoInicial>0, "Sem dinheiro, sem conta");
        require(_enderecoCliente != address(0), "endereco invalido");
        require(!clientes[_enderecoCliente].status, "conta existente e aberta");
        Conta memory novaConta = Conta(_nomeCliente, _enderecoCliente, _depositoInicial, true);
        clientes[_enderecoCliente] = novaConta;
        totalDeContas++;
        return true;
    }

    function setSaldo(address _enderecoCliente, uint novoValor_) 
    external 
    somenteContaAberta(_enderecoCliente)
    returns(bool) {        
        require(novoValor_ > 0, "valor invalido");
        clientes[_enderecoCliente].saldo = novoValor_;
        return true;
    }

    function retirarClienteAzarado(address _enderecoCliente) 
    external 
    somenteContaAberta(_enderecoCliente) 
    returns(bool) {    
        if (clientes[_enderecoCliente].saldo != 13) {
            revert("ufa... esse passou!");
        }
        //fecho a conta
        clientes[_enderecoCliente].status = false;
        totalDeContas--;
        return true;
    }

    function getDadosConta(address _enderecoCliente)
    external
    view
    somenteContaAberta(_enderecoCliente)
    returns(Conta memory conta) {  
        conta = clientes[_enderecoCliente];
        return conta; 
    }
}
