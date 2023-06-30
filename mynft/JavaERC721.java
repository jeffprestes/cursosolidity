/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

 package br.com.7comm.java.erc721;

 import java.math.BigDecimal;
 import java.math.BigInteger;
 import org.web3j.protocol.Web3j;
 import org.web3j.protocol.http.HttpService;
 import org.web3j.crypto.Credentials;
 import org.web3j.contracts.eip20.generated.ERC20;
 import org.web3j.protocol.core.methods.response.TransactionReceipt;
 import org.web3j.tx.Transfer;
 
 import org.web3j.tx.gas.DefaultGasProvider;
 import org.web3j.utils.Convert;
 /**
  *
  * @author jeffprestes
  */
 public class JavaErc721 {
 
     public static void main(String[] args) throws Exception {
         String rpcEndpoint = "https://matic-mumbai.chainstacklabs.com";
         Web3j web3j = Web3j.build(new HttpService(rpcEndpoint));
         
         // Preparing wallet
         String pk = "";
         // Account address: 0x2E69508520ed70Bd227bcb8fa68865F1F0756c12
         Credentials credentials = Credentials.create(pk);
 
         System.out.println("Enviando ether....");
         
         TransactionReceipt transactionReceipt = Transfer.sendFundsEIP1559(
                 web3j, 
                 credentials, 
                 "0x2A97A7fDd5D7732A6dBAf69d1cfB2e9aEDD2279C", 
                 BigDecimal.valueOf(0.01), 
                 Convert.Unit.ETHER, 
                 BigInteger.valueOf(8_000_000), 
                 BigInteger.valueOf(3_100_000_000L), 
                 BigInteger.valueOf(3_100_000_000L))
         .send();
 
         if (transactionReceipt.isStatusOK()) {
             System.out.println("Ether enviado");
         }
 
         // Load the contract
         String contractAddress = "0x41A3C7bBCD6EEbf60B689b3D103C742A23E56298";
         ERC20 javaToken = ERC20.load(contractAddress, web3j, credentials, new DefaultGasProvider());
         String nomeToken = javaToken.name().send();
         System.out.println("Nome do token: " + nomeToken);
     }
 }
 