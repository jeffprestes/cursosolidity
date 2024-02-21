/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/

pragma solidity 0.8.4;

import "./lib-interface-erc20.sol";

contract Saldo {

    function obtemSaldo(address token_, address pessoa_) public view returns (uint256) {
        IERC20 token = IERC20(token_);
        return token.balanceOf(pessoa_);
    }

    function saldoMoeda(address pessoa_)  public view returns (uint256) {
        return pessoa_.balance;
    }

}

