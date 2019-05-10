pragma solidity 0.5.8;

contract Leilao {

    struct Ofertante {
        string nome;
        address payable enderecoCarteira;
        uint oferta;
        bool jaFoiReembolsado;
    }
    
    address payable public contaGovernamental;
    uint public prazoFinalLeilao;

    address public maiorOfertante;
    uint public maiorLance;

    mapping(address => Ofertante) public listaOfertantes;
    Ofertante[] public ofertantes;

    bool public encerrado;

    event novoMaiorLance(address ofertante, uint valor);
    event fimDoLeilao(address arrematante, uint valor);

    modifier somenteGoverno {
        require(msg.sender == contaGovernamental, "Somente Governo pode realizar essa operacao");
        _;
    }

    constructor(
        uint _duracaoLeilao,
        address payable _contaGovernamental
    ) public {
        contaGovernamental = _contaGovernamental;
        prazoFinalLeilao = now + _duracaoLeilao;
    }


    function lance(string memory nomeLeiloeiro, address payable enderecoCarteiraLeiloeiro) public payable {
        require(now <= prazoFinalLeilao, "Leilao encerrado.");
        require(msg.value > maiorLance, "Ja foram apresentados lances maiores.");
        
        maiorOfertante = msg.sender;
        maiorLance = msg.value;
        
        //Realizo estorno das ofertas aos perdedores
        /*
        For é composto por 3 parametros (separados por ponto virgula)
            1o  é o inicializador do indice
            2o  é a condição que será checada para saber se o continua 
                o loop ou não 
            3o  é o incrementador (ou decrementador) do indice
        */
        for (uint i=0; i<ofertantes.length; i++) {
            Ofertante memory leiloeiroPerdedor = ofertantes[i];
            if (!leiloeiroPerdedor.jaFoiReembolsado) {
                leiloeiroPerdedor.enderecoCarteira.transfer(leiloeiroPerdedor.oferta);
                leiloeiroPerdedor.jaFoiReembolsado = true;
            }
        }
        
        //Crio o ofertante
        Ofertante memory concorrenteVencedorTemporario = Ofertante(nomeLeiloeiro, enderecoCarteiraLeiloeiro, msg.value, false);
        
        //Adiciono o novo concorrente vencedor temporario no array de ofertantes
        ofertantes.push(concorrenteVencedorTemporario);
        
        //Adiciono o novo concorrente vencedor temporario na lista (mapa) de ofertantes
        listaOfertantes[concorrenteVencedorTemporario.enderecoCarteira] = concorrenteVencedorTemporario;
    
        emit novoMaiorLance (msg.sender, msg.value);
    }

   
    function finalizaLeilao() public somenteGoverno {
       
        require(now >= prazoFinalLeilao, "Leilao ainda nao encerrado.");
        require(!encerrado, "Leilao encerrado.");

        encerrado = true;
        emit fimDoLeilao(maiorOfertante, maiorLance);

        contaGovernamental.transfer(address(this).balance);
    }
}
