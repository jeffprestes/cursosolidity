//Exemplo de parse de log de eventos de smart contracts solidity usando ethers.js javascript js

// coloque na variavel/constante abaixo a declaração do evento igual esta no solidity
const abi = [
  "event NewWalletCreated(address walletAddress, address indexed controller, string recipientExternalID)",
];
const iface = new ethers.utils.Interface(abi);
//peça para fazer o parse do log desejado. se houver mais de um evento na mesma tx veja qual o indice do mesmo
const logParsed = iface.parseLog(txResult.logs[0]);
const logParsedValues = logParsed.values;
console.log("Tx logs", logParsedValues, " wallet is", logParsedValues.walletAddress);
