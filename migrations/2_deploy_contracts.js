const FundFactory = artifacts.require("FundFactory")
const Fund = artifacts.require("Fund")
//const accounts = await web3.eth.getAccounts();
const accounts = async ()=>{return await web3.eth.getAccounts();}
module.exports = async function(deployer) {
    
    deployer.deploy(FundFactory);
    deployer.deploy(Fund,1000,'0xaA3c394D979757045CbB73Be2E5867E5Ee8f6CB0',"Sup","to test");
}
