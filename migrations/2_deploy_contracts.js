const Fund = artifacts.require("Fund")

module.exports = function(deployer) {
    deployer.deploy(Fund,1000,"Sup","to test");
}
