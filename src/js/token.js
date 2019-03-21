import contract from "truffle-contract";
import DemoContract from "@contracts/demo.json";

const Users = {
  contract: null,

  instance: null,

  init_token: function() {
    let self = this;

    return new Promise(function(resolve, reject) {
      self.contract = contract(DemoContract);
      self.contract.setProvider(window.web3.currentProvider);

      self.contract
        .deployed()
        .then(instance => {
          self.instance = instance;
          resolve();
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  buy: function(msg, amount) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .buy(msg, {
          from: window.web3.eth.accounts[0],
          to: window.web3.eth.defaultAccount,
          value: amount
        })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  sell: function (token, Eth_amount) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .sell(token, Eth_amount, { from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  displaybalance: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .displaybalance({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  displayethbalance: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .displayethbalance({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  displayaccount: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .displayaccount({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  displaytoken: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .displaytoken({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  distranumber: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .distranumber({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  }
};

export default Users;
