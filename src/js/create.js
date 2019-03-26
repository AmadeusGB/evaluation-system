import contract from "truffle-contract";
import DemoContract from "@contracts/demo.json";

var number = 1;
var valuation_number;

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

  addvaluation: function(
    Frame_number,
    Number_plate,
    Vehicle_type,
    Brand_number,
    Engine_number,
    Manufacture_date,
    submit_date
  ) {
    let self = this;

    var date = new Date();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
      month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
      strDate = "0" + strDate;
    }
    valuation_number =
      date.getFullYear() +
      month +
      strDate +
      (Array(5).join(0) + number++).slice(-5);
    console.log(valuation_number);

    return new Promise((resolve, reject) => {
      self.instance
        .addvaluation(
          Frame_number, //车架号
          Number_plate, //号码车牌
          Vehicle_type, //车辆类型
          Brand_number, //品牌型号
          Engine_number, //发动机号码
          Manufacture_date, //出厂日期
          "0", //评估价值(初始化为0)
          submit_date, //时间戳(提交日期)
          valuation_number, //评估单编号
          {
            from: window.web3.eth.accounts[0]
          }
        )
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  addphoto: function(
    photo1,
    photo2,
    photo3,
    photo4,
    photo5,
    photo6,
    photo7,
    photo8
  ) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .addphoto(
          photo1,
          photo2,
          photo3,
          photo4,
          photo5,
          photo6,
          photo7,
          photo8,
          valuation_number, //评估单编号
          {
            from: window.web3.eth.accounts[0],
            value: "100"
          }
        )
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  backvaluation: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .backvaluation({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  setstate: function(index, condition) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .setstate(index, condition, { from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  appealdistribution: function(
    number,
    appeal1,
    appeal2,
    appeal3,
    appeal4,
    appeal5
  ) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .appealdistribution(
          number,
          appeal1,
          appeal2,
          appeal3,
          appeal4,
          appeal5,
          { from: window.web3.eth.accounts[0] }
        )
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  displayaccountforarbitrage: function(send) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .displayaccountforarbitrage(send, { from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  backofwork: function() {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .backofwork({ from: window.web3.eth.accounts[0] })
        .then(tx => {
          resolve(tx);
        })
        .catch(err => {
          reject(err);
        });
    });
  },

  test1: function(num, index) {
    let self = this;

    return new Promise((resolve, reject) => {
      self.instance
        .display(num, index, { from: window.web3.eth.accounts[0] })
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
