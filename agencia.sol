//Contrato desenvolvido originalmente por @gabrilli

pragma solidity 0.5.8;

contract AgenciaViagem {
        
    address payable public _Agencia;
    address payable public _CiaArea;
    uint256 public _ValorDaPassagem;
    uint256 public _CapacidadeAeronave;
    bool public Encerrado;
    bool public EstornoFeito;

    struct Interessado {
        address payable Cliente;
        string Nome;
    }
    
    Interessado[] public ListaA;
    
    mapping(address => Interessado) private ListaM;

    constructor (
        address payable CiaAerea,
        uint256 ValorDaPassagem,
        address payable Agencia,
        uint256 CapacidadeAeronave
    )
    public {
        _Agencia = Agencia;
        _CiaArea = CiaAerea;
        _ValorDaPassagem = ValorDaPassagem;
        _CapacidadeAeronave = CapacidadeAeronave;
        
    }
    
  
    
    modifier SomenteAgencia () {
        require (msg.sender == _Agencia, "Aguarde o chamado da Agencia");
        _;
    }
    
    
    function FazerReserva (address payable Cliente, string memory Nome) public payable  {
        require (msg.value == _ValorDaPassagem, "Pague o valor correto");
        
        Interessado memory Passageiro = Interessado(Cliente, Nome);
        
        ListaA.push(Passageiro);
        
        ListaM[Cliente] = Passageiro;
    }    
        
   
    function EncerrarLista () public SomenteAgencia  {
        Encerrado = true;
    }    
        
    function Estorno () public SomenteAgencia payable {
        require (Encerrado == true);
        require (ListaA.length > _CapacidadeAeronave);
        
        for (uint256 i=(_CapacidadeAeronave+1); i<=ListaA.length ; i++) {
      
           Interessado memory PassageiroDescartado = ListaA[i];
           
           PassageiroDescartado.Cliente.transfer(_ValorDaPassagem); //deu pau, ele não aceita uma variavel, apenas o que ta dentro da struct
           
           EstornoFeito = true;
        
       }
    }    
   
   function PagarCia (uint256) public payable {
       
       require (EstornoFeito == true);
       
       _CiaArea.transfer(address(this).balance);
       
        
   }
   
   
}   
      
