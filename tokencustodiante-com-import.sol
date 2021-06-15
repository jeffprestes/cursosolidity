/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/

pragma solidity 0.8.0;

import "./lib-interface-erc20.sol";

contract Custodiante {
    
    IERC20 public token; 
    address public administrador;
    
    constructor(address _enderecoToken) {
        token = IERC20(_enderecoToken);
        administrador = msg.sender;
    }
    
    function mudarToken(address _enderecoToken) public returns (bool) {
        require(msg.sender == administrador, "Somente administrador pode mudar o token");
        token = IERC20(_enderecoToken);
        return true;
    }
    
    function saldoCustodiante() public view returns (uint) {
        return token.balanceOf(address(this));
    }
    
    function qualMeuToken() public view returns (string memory, string memory) {
        return (token.name(), token.symbol());
    }
}
