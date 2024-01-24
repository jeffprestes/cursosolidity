const ethers = require('ethers')
const wallet = ethers.Wallet.createRandom()
const walletResp = {
    mnemonic: wallet.mnemonic.phrase,
    address: wallet.address,
    privateKey: wallet.privateKey
}
console.log(walletResp)
