const EthSwap = artifacts.require("EthSwap");
const Token = artifacts.require("Token");

module.exports = async function(deployer) {
  // Deploy Token
  await deployer.deploy(Token);
  const token = await Token.deployed()

  // Deploy Ethswap
  await deployer.deploy(EthSwap);
  const ethSwap = await EthSwap.deployed()

  // transfer token to ethSwap 1 million
  await token.transfer(ethSwap.address, '1000000000000000000000000')
};
