import contract from "truffle-contract";
import DemoContract from "@contracts/demo.json";

const Users = {
  contract: null,

  instance: null,

  init_user: function() {
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

  registertest: function (msg, scale, amount) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .registertest(msg, scale, {
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

  Enter_quote: function(msg) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .Enter_quote(msg,{ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  checkuser: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .checkuser({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  unregister: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .unregister({ from: window.web3.eth.accounts[0] })
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
