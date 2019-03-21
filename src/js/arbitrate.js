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

  evaluate: function(index, value) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .evaluate(index, value, { from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  backwork: function(index) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .backwork(index, { from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  backappnumber: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .backappnumber({ from: window.web3.eth.accounts[0] })
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
