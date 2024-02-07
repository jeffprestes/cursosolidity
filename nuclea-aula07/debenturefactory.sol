// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import "./debenture.sol";

contract DebentureFactory {

    Debenture[] public debenturesEmitidas;

    function emiteDebenture(string memory emissor_) public returns (address) {
        Debenture debenture = new Debenture(emissor_);
        debenturesEmitidas.push(debenture);
        return address(debenture);
    }

}