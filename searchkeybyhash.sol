pragma solidity 0.5.12;

contract SearchKeyByHash
{
    struct CertificadoAluno {
        string cpf;
        string codigoCurso;
        string texto;
        bool exists;
    }
    
    mapping(bytes32 => CertificadoAluno) public certificados;
    
    function addCertificado(string memory _cpf, string memory _codigoCurso, string memory _texto)
        public
        returns (bytes32)
    {
        CertificadoAluno memory ca = CertificadoAluno(_cpf, _codigoCurso, _texto, true);
        bytes32 hashCertificado = keccak256(abi.encodePacked(_cpf, _codigoCurso));
        certificados[hashCertificado] = ca;
        return hashCertificado;
    }
    
    function buscaCertificado(string memory _cpf, string memory _codigoCurso)
        public
        view
        returns (string memory, string memory, string memory)
    {
        CertificadoAluno memory ca = certificados[keccak256(abi.encodePacked(_cpf, _codigoCurso))];
        require(ca.exists, "Certificado nao existe com para esse CPF e codigo de curso");
        return (ca.cpf, ca.codigoCurso, ca.texto);
    }
}
