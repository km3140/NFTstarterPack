var helloWorld = artifacts.require("helloWorld");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(helloWorld);
};