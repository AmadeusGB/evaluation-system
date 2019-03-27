var demo = artifacts.require("./demo.sol");
//var token = artifacts.require("./token.sol");

module.exports = function(deployer) {
  deployer.deploy(demo);
  //deployer.deploy(token);
};
