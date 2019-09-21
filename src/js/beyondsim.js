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

  robin: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .robin({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  check: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .check({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  backrecordnumber: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .backrecordnumber({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  displaymodelinfo: function(index, num,flag) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .displaymodelinfo(index, num, flag,{ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  displayaddressinfo: function(index,num,flag) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .displayaddressinfo(index, num,flag,{ from: window.web3.eth.accounts[0] })
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
