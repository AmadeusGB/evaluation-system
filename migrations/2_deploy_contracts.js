var demo = artifacts.require("./demo.sol");
// var Users = artifacts.require("./Users.sol");
var token = artifacts.require("./token.sol");
// var login = artifacts.require("./login.sol");
// var create = artifacts.require("./create.sol");

module.exports = function(deployer) {
  deployer.deploy(demo);
  deployer.deploy(token);
  // deployer.deploy(Users);
  // deployer.deploy(login);
  // deployer.deploy(create);
};
