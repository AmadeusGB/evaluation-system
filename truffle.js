module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      gas: 68000000,
      network_id: "*" // Match any network id
    }
  }
};
