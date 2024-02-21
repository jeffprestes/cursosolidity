// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract EmprestimoCall {

    address public addTaxa = 0x53958CAB8B8549970B2A8a63075D2FA2ea33c256;

    function setTaxaComCall(uint256 _val) public returns (bytes memory) {
        (bool success, bytes memory data) = addTaxa.call(abi.encodeWithSignature("setTaxaBase(uint256)", _val));
        if(!success) {
            revert("function call has failed");
        }
        return (data);
    }
    
    function getTaxaViaCall() public returns (uint256) {
        (bool success, bytes memory data) = addTaxa.call(abi.encodeWithSignature("taxaBase()"));
        require(success, "function call has failed");        
        return abi.decode(data, (uint256));        
    }    
}
