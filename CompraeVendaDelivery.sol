pragma solidity 0.5.12;

contract rappi
{
    string public vendedor;
    string public comprador;
    uint256 public distancia;
    uint256 public valordoProduto;
    uint256 constant valorEntregaGratis = 0 ;
    bool[] public statusPagamento;
    address payable public contaVendedor;

    constructor(string memory nomevendedor, string memory nomecomprador, uint256 valorObjeto, uint256 distanciaEntrega, address payable paramContaVendedor) public    
    {
    vendedor = nomevendedor;
    comprador = nomecomprador;     
    distancia = distanciaEntrega;
    valordoProduto = valorObjeto;
    contaVendedor = paramContaVendedor;
    }

    function valordaEntrega (uint) public view returns (uint valordaEntrega)
    {
        if (distancia> 5)
        {
            require(distancia>4, "será cobrada taxa de entrega");
            for (uint256 i=5; i<=distancia; i++)
                valordaEntrega = distancia;
        }
        else (distancia <= 5);
        {
            valordaEntrega = valorEntregaGratis;
        }
    }
    
    function valorTotalCompra (uint256 valordaEntrega) public view returns (uint valorTotaldaCompra)
    {
        valorTotaldaCompra = valordaEntrega + valordoProduto;
    }
    
    function receberPagamento() public payable
    {
       require(msg.value>= uint valorTotaldaCompra, "Pagamento da Compra");
       contaVendedor.transfer(msg.value);
       statusPagamento.push(true);
    }
}
