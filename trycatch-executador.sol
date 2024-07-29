// SPDX-License-Identifier: GPL-3.0
// Example based on https://www.rareskills.io/post/try-catch-solidity

pragma solidity 0.8.25;


contract Executador {

    error ErroCustomizado(uint256 saldo);

    uint256 public saldo = 10;

    function qualSaldoAtual() external view returns (uint256) {
        return saldo;
    }

    function reduzirSaldo() external {
        require(saldo >= 5, "Saldo esta muito baixo");
        saldo--;
    }

    function testeReversao() external view {
        if (saldo == 9) {
            revert();
        }

        if (saldo == 8) {
            uint256 a = 1;
            uint256 b = 0;
            // A operacao abaixo eh ilegal e deve disparar um panic devido a divisao por zero
            a / b;
        }

        if (saldo == 7) {
            revert("mensagem de reversao");
        }

        if (saldo == 6) {
            revert ErroCustomizado(100);
        }

        if (saldo == 5) {
            require(saldo > 5, "Saldo esta muito baixo");
        }
    }
}

