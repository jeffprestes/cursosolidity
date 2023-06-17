// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./aula07.sol";

interface ICaixa {
    function myBalance() external view returns (uint256);
}

contract Caixa {
    // Payable address can receive Ether
    address payable public owner;

    event Track(string indexed _function, address sender, uint value, bytes data);


    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.
    function deposit() public payable {
        emit Track("deposit()", msg.sender, msg.value, "");
    }

    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    // Function to withdraw all Ether from this contract.
    function withdraw() public {
        require(msg.sender == owner, "only owner can withdraw");
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        require(msg.sender == owner, "only owner can withdraw");
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }

    receive() external payable {
        (bool success, ) = msg.sender.call{value: msg.value}("");
        require(success, "it was not sent to the owner");
        emit Track("receive()", msg.sender, msg.value, "");
    }

    function myBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

contract NoCash {
    event Track(string indexed _function, address sender, uint value, bytes data);

    fallback() external payable {
        emit Track("fallback()", msg.sender, msg.value, msg.data);
    }
}

contract Autorizador {
    ICaixa public caixa;
    IERC20 public token;

    constructor() {
        caixa = ICaixa(0xD7170F4cE3be4707Ee34c15De8057775414db5Ee);
        token = IERC20(0x8eE5B68e89d86f5662d02200cD0FF7baa8065067);
    }

    function estaAutorizado(address _conta) external view returns (bool) {
        return caixa.myBalance()>0 && token.balanceOf(_conta)>0;
    }

    function estouAutorizado() external view returns (bool) {
        return token.balanceOf(address(this))>0;
    }
}

contract ClienteBanco {
    string public cpf;
    IERC20 public token;
    address public chaveUm;
    address public chaveDois;
    uint8 public autorizacoes;

    event AutorizacaoDada(address chave, uint data);

    constructor(string memory _cpf) {
        cpf = _cpf;
        chaveUm = msg.sender;
        chaveDois = address(0x8e287B1F206eF762D460598bdE1A9C22db6b6382);
        token = IERC20(0x8eE5B68e89d86f5662d02200cD0FF7baa8065067);
    }

    function saldoCliente() external view returns (bool) {
        return token.balanceOf(address(this))>0;
    }

    function autorizo() external returns (bool) {
        require(msg.sender == chaveUm || msg.sender == chaveDois, "somente o banco pode fazer essa operacao");
        autorizacoes++;
        emit AutorizacaoDada(msg.sender, block.timestamp);
        return true;
    }

    function saqueTotal(address _to) external returns (bool) {
        require(msg.sender == chaveUm || msg.sender == chaveDois, "somente o banco pode fazer essa operacao");
        if (token.balanceOf(address(this)) > 1000) {
            require(autorizacoes == 2, "nao possue autorizacoes necessarias");
        }
        bool success = token.transfer(_to, token.balanceOf(address(this)));
        require(success, "houve falha no saque");
        autorizacoes = 0;
        return success;
    }
}
