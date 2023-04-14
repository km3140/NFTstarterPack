const FlightLog = artifacts.require("FlightLog")

module.exports = function(deployer) {
  deployer.deploy(FlightLog);
}