// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Cadastro: 0x90bd50B003A79b8C99C402476D297A2cE50fa3ca

contract Cadastro {

    struct Cliente {
        uint256 id;
        string primeiroNome;
        string sobreNome;
        address payable endereco; //0x0
        bytes32 hashConta; // 0x0        
        bool existe; //false
    }

    uint256 public totalClientes;

    Cliente[] public clientes;

    function addCliente(
        string memory _primeiroNome,
        string memory _sobreNome,        
        string memory _agencia,
        string memory _conta
    ) external returns (bool) {
        string memory strTemp = string.concat(_agencia, _conta);
        bytes memory bTemp = bytes(strTemp);
        bytes32 hashTemp = keccak256(bTemp);

        Custodia custodiaTemp = new Custodia(hashTemp);

        Cliente memory cliente = Cliente(totalClientes, _primeiroNome, _sobreNome, payable(address(custodiaTemp)), hashTemp, true);
        totalClientes++;
        
        clientes.push(cliente);
        
        return true;
    }

    function getClientePeloId(uint256 _id) external view returns (Cliente memory cliente_, bool existe) {
        cliente_ = clientes[_id];
        existe = cliente_.existe;
        return (cliente_, existe);
    }

}

contract Custodia {
    bytes32 public hashConta;

    event EtherRecebido();

    constructor(bytes32 _hashConta) {
        hashConta = _hashConta;
    }

    receive() external payable {
        emit EtherRecebido();
    }
    
}