pragma solidity 0.5.8;

contract Leilao {

    address payable public contaGovernamental;
    uint public prazoFinalLeilao;

    address public maiorOfertante;
    uint public maiorLance;

    mapping(address => uint) public lancesRealizados;

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


    function lance() public payable {
 
        require(
            now <= prazoFinalLeilao,
            "Leilao encerrado."
        );

        require(
            msg.value > maiorLance,
            "Ja foram apresentados lances maiores."
        );
        
        maiorOfertante = msg.sender;
        maiorLance = msg.value;
         
        if (maiorLance != 0) {
            lancesRealizados[maiorOfertante] = maiorLance;
        }
        
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
