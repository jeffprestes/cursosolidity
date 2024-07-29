// SPDX-License-Identifier: GPL-3.0
// Example based on https://www.rareskills.io/post/try-catch-solidity

pragma solidity 0.8.25;

import "hardhat/console.sol";
import { Executador } from "./trycatch-executador.sol";

contract Remetente {

    event ErroManipulado(uint256 saldo);

    Executador public exec;

    constructor(address executadorEndereco_) {
        exec = Executador(executadorEndereco_);
    }

    function chamaExecutador() external view {
        try exec.testeReversao() {
            uint256 tempSaldo = exec.qualSaldoAtual();
            console.log("Sucesso! Saldo: ", tempSaldo);
            
        } catch Panic(uint256 codigoErro) {
            console.log("codigo do erro que aconteceu: ", codigoErro);

        } catch Error(string memory motivoDoErro) {
            console.log("Erro aconteceu por este motivo: ", motivoDoErro);

        } catch (bytes memory dadoBaixoNivel) {
            if (dadoBaixoNivel.length == 0) {
                console.log("reversao sem uma mensagem");
            }
            if (bytes4(abi.encodeWithSignature("ErroCustomizado(uint256)")) == bytes4(dadoBaixoNivel)) {
                console.log("ErroCustomizado foi disparado");
            }
        }
    }
}
