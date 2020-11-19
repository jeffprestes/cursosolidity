/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.
Example to show how to use customized (or personal) library
*/
pragma solidity 0.7.4;

import {Count} from './library_example_count.sol';

contract Matematica {
    
    using Count for Count.Hold;
    using Count for uint;
    
    Count.Hold holder;
    mapping(uint => Count.Hold) mapHolders;
    
    constructor() {
        mapHolders[0] = Count.Hold(10);
    }
    
    function add(uint _a, uint _b) public pure returns(uint) {
        return _a.addUint(_b);
    }
    
    function subValueFromFirstHold(uint _value) public view returns (uint) {
        return mapHolders[0].subUint(_value);
    }
}