// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract OlaMundoDa7Comm {

    string[] public nomeAlunos;

	function olaMundo() public pure returns (uint256) {
		return 100;
	}
	
	function haloDunia() public pure returns (bool) {
		return true;
	}

    function testeIf(uint8 opcao) external pure returns (string memory nomeOpcao) {
        if (opcao == 0) {
            nomeOpcao = "a";
        } else if (opcao == 1) {
            nomeOpcao = "b";
        } else {
            nomeOpcao = "nao sei";
        }
        return nomeOpcao;
    }

    function useArrayForUint256(uint256[] calldata input) public pure returns (uint256[] memory) {
        return input;
    }

    function addAluno(string calldata _nomeNovoAluno) external returns (bool) {
        nomeAlunos.push(_nomeNovoAluno);
        return true;
    }

    function getAluno(uint _raDoAluno) external view returns (string memory nomeAluno) {
        if (_raDoAluno >= nomeAlunos.length) {
            return nomeAluno;
        }
        nomeAluno = nomeAlunos[_raDoAluno];
        return nomeAluno;
    }

    function setAlunoEmBatch(string[] calldata _nomesAlunos)
    external returns (uint) {
        for (uint i; i<_nomesAlunos.length; i++) {
            nomeAlunos.push(_nomesAlunos[i]);
        }
        return nomeAlunos.length;
    }

}
