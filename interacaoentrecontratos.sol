pragma solidity 0.5.11;

contract Persona {
    
    mapping (address => string) public infoPersona;
    address public addressValidator;
    
    constructor() public {
    }  
    
    function addPersona (address _address, string memory _info) public {
        infoPersona[_address] = _info;
    }
    
    function getInfoPersona (address _address) public view returns (string memory) {
        return infoPersona[_address];
    }
    
    function setSCValidator(address _address) public {
        addressValidator = _address;
    }
    
    function isValidator(address _address) public view returns (bool) {
        Validator validator = Validator(addressValidator);
        return validator.checkValidator(_address);
    }    
    
    
}


contract Validator {
    
    mapping (address => bool) public isValidator;
    address public addressPersona;
    
    constructor(address _addressPersona) public {
        addressPersona = _addressPersona;
    }  
    
    function addValidator (address _address) public {
        isValidator[_address] = true;
    }
     
    function checkValidator (address _address) public view returns (bool) {
        return isValidator[_address];
    }
    
    function getInfo (address _address) public view returns (string memory) {
        Persona persona = Persona(addressPersona);
        string memory info = persona.getInfoPersona(_address);
        return info;
    }    
    
}
