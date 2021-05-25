// SPDX-License-Identifier: NONE
// Contrato criado inicialmente por Claudio Girao Barreto

pragma solidity 0.8.4;

 // Permite consultar a subseção competente após ser informado o município onde reside a parte autora
 
contract ConsultaSubsecaoMunicipio {

    // mapeamento de município para subseção
    mapping (string => string) public competencias; 
    // etiqueta ou chave ou key -> nome do municipio
    // e dentro do item será armazenado string (texto)
    
    mapping (uint => string) public regioes;
    // 1 -> DF
    // 2 -> RJ e ES 
    // 3 -> SP e MS 
    // 4 -> PR, SC, RS
    // 5 -> PE, AL, PB, RN, CE
    
    //Array de strings
    string[] public leis;
    // Atribuicao da chave é feita automaticamente pelo solidity
    // A chave é um numero inteiro sequencial
    
    
    constructor() {
        regioes[1] = "DF";
        regioes[2] = "RJ e ES";
        regioes[3] = "SP e MS";
        regioes[4] = "PR, SC, RS";
        regioes[5] = "PE, AL, PB, RN, CE";
        leis.push("lei de vargas");  // 0
        leis.push("Marco Civil da Internet"); // 1
    }
    
    function incluirLei(string memory _nomeDaLei) public {
        leis.push(_nomeDaLei);
    }
    
    function consultarNomeLei(uint _numeroDaLei) public view returns(string memory) {
        return leis[_numeroDaLei];
    }

    // permite vincular no mapping o município à subseção
    function incluirMunicipioEmSubsecao(string memory _municipio, string memory _subsecao) public {
        competencias[_municipio] = _subsecao;
    }
    
    // consultar a subseção a que se vincula o município
    function consultarSubsecaoDoMunicipio(string memory _municipio) public view returns (string memory){
        return competencias[_municipio];
    }
    
}
