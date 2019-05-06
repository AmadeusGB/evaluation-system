<template>
  <div class="box1">
      <div class="basicinfo">
        <div>
          <span class="span-header">&nbsp;&nbsp;基本信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
          <span class="span-content" style="top:160px;left:20px;" v-if="identity == 0">当前身份：普通用户</span>
          <span class="span-content" style="top:160px;left:20px;" v-if="identity == 1">当前身份：评估师</span>
          <el-button type="primary" size="mini" class="span-content" style="font-size: 11px;top:161px;left:160px;" @click="onSubmit" v-if="identity == 0">注册评估师</el-button>
          <el-button type="primary" size="mini" class="span-content" style="font-size: 11px;top:161px;left:140px;" @click="logout" v-if="identity == 1">注销</el-button>
          <span class="span-content" style="top:190px;left:20px;">注册时间：{{registertime}}</span>
          <span class="span-content" style="top:190px;left:300px;">参与工单：{{workorder}}</span>
          <span class="span-content" style="top:190px;left:580px;" v-if="identity == 0">申诉率：{{rate}}%</span>
          <span class="span-content" style="top:190px;left:580px;" v-if="identity == 1">好评率：{{rate}}%</span>
          <span class="span-content" style="top:190px;left:860px;" v-if="identity == 1">当前订单提成：{{currentscale}}%</span>
        </div>
      </div>

      <div class="tokeninfo">
        <div>
          <span class="span-header">&nbsp;&nbsp;支付清算</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">

          <el-table ref="singleTable" :data="tableData" highlight-current-row style="width: 100%;border: 0px">
            <el-table-column prop="address" label="用户地址" width="350"></el-table-column>
            <el-table-column prop="balance" label="账户余额" width="200"></el-table-column>
            <el-table-column prop="token" label="持有通证" width="125"></el-table-column>
            <el-table-column prop="tokenprice" label="通证价格" width="125"></el-table-column>
            <el-table-column prop="transaction" label="操作次数" width="100"></el-table-column>
            <el-table-column prop="worth" label="总价值" width="120"></el-table-column>

            <el-table-column fixed="right" label="操作" width="170">
                <template slot-scope="scope">
                    <el-button @click="buytoken(scope.row)" type="text" size="small">购买通证</el-button>
                    <el-button @click="selltoken(scope.row)" type="text" size="small">卖出通证</el-button>
                </template>
            </el-table-column>            
          </el-table>
        </div>        
      </div>

    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <span>设置订单提成 : {{scale}}% （提成过高可能会影响竞争力）</span>
        <el-slider v-model="scale" :format-tooltip="formatTooltip" :step="5"  show-stops></el-slider>
        <el-button type="primary" @click="setparameter">修改</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>


<script>
import token from "@/js/token";
import login from "@/js/login";
import Eva from "@/js/evaluate";
import Demo from "@/js/create";

export default {
  data() {
    return {
      msg: [
        "车架号：",
        "号码车牌：",
        "车辆类型：",
        "品牌型号：",
        "发动机号码：",
        "出厂日期：",
        "时间戳："
      ],
      pmsg: [
        "合格证",
        "左前45度",
        "左前门",
        "左后门",
        "右前门",
        "右后45度",
        "中控台",
        "车内顶"
      ],
      carInfo : {
        Frame_number:"WP1AG2928CLA69271",
        Number_plate:"京A 00001",
        Vehicle_type:"非营运",
        Brand_number:"保时捷Cayenne2011款 Cayenne 3.0T",
        Engine_number:"CWW006067",
        Manufacture_date:"2019-1-1",
        Timestammp:"2019-1-1 12:00:00"
      },
      photo : {
        photo1 : "http://localhost:5000/ipfs/QmbrZJ6xLozpZck7ASRHJhWA46RGprR2gNjKXF2x2aSy94",
        photo2 : "http://localhost:5000/ipfs/QmR65AtAHL5LfTpAjJViWRQJuaEK7w5yqZJopfY667LtYC",
        photo3 : "http://localhost:5000/ipfs/QmYgZhxc2PZGAZPocafF9j6jbcrRemrWBD37vgVeScJtGY",
        photo4 : "http://localhost:5000/ipfs/QmWVMBfgfTCCsVXuaLmDj5kWnq2oogCJXpeQ3ZPgf7yXtQ",        
        photo5 : "http://localhost:5000/ipfs/QmRPwJVvskWce4FTdtYbjp2DMHeRsGXzAd8xUMiS8Sau2k",
        photo6 : "http://localhost:5000/ipfs/Qmb7MmpzvKaVDZdTqeARVAT9eo9eTB66kX63pRq3Q4AK1Z",
        photo7 : "http://localhost:5000/ipfs/QmY3zSrCWVuYMQ1yTR3qZfGiNMBBE42d1s8gaRVdYDqUHP",
        photo8 : "http://localhost:5000/ipfs/Qmcin3oqk6WGGdFWGR9AHQTkfooZ9LGpCoU9f3ck7hDdtX"
      },
      scale: 50,
      identity:'',
      registertime:'',
      workorder:'',
      rate:'',
      currentscale:'',
      tableData: []
    };
  },
  created: async function() {
    await login.init_user();
    await token.init_token();
    await Eva.init_user();
    await Demo.init_user();
    
    this.identity = await login.checkuser();
    
    if(this.identity == 1) {
      this.registertime = await login.checktime();
      this.workorder = (await Eva.backvalnumber()).length;
      
      if(this.workorder) {
        this.rate = ((this.workorder - await login.displaywork()) / this.workorder)*100;
      }
      else {
        this.rate = 0;
      }
    }
    else {
      try {
        var blockurl = 'http://localhost:6001/search/blocklist?key=owner&param=' + window.web3.eth.accounts[0];
        var responseblockinfo = await fetch(blockurl);      
        var blockinfo = await responseblockinfo.json();

        this.registertime = blockinfo[0].timestamp;
        this.workorder = (await Demo.backvaluation()).length;
        if(this.workorder) {
          this.rate = (await login.displaycreate() / this.workorder)*100;
        }
        else {
          this.rate = 0;
        }
      }
      catch(err){

      }
    }

    this.currentscale = 100 - await login.check_quote();

    var balance = await token.displaybalance();
    var account = await token.displayaccount();
    var CirculationToken = await token.displaytoken();
    if (balance == 0) balance = 0.1;
    var price = balance / (CirculationToken * 0.5);
    var Eth_amount = (1 - Math.pow(1 - account / CirculationToken, 2)) * balance;
    Eth_amount = Math.abs(Eth_amount);

    var result =
      '[{"address":"' +
      (await window.web3.eth.accounts[0]) +
      '","balance":"' +
      (await token.displayethbalance()) +
      '","token":"' +
      (account) +
      '","tokenprice":"' +
      price.toFixed(2) +
      '","worth":"' +
      Eth_amount.toFixed(0) +
      '","transaction":"' +
      (await token.distranumber()) +
      '"}]';
    this.tableData = JSON.parse(result);
  },
  methods: {
    async onSubmit() {
      this.$router.push({ name: "register1", params: { id: "1" } });
    },
    async setparameter() {         
      var commission = 200 - this.scale;
      var blockmsg = await login.Enter_quote(commission);

      var blockurl = "http://localhost:6001/insert/blocklist";
      var mytime = new Date().toLocaleString('chinese', { hour12: false });
      var httpRequestblocklist = new XMLHttpRequest();
      var context = "注册评估师：" + window.web3.eth.accounts[0];
      var blocktext = {
        owner: window.web3.eth.accounts[0],
        address: "无",
        gasused: blockmsg.receipt.gasUsed,
        timestamp: mytime,
        blockhash: blockmsg.receipt.blockHash,
        blocknumber: blockmsg.receipt.blockNumber,
        transactionid: blockmsg.receipt.transactionHash,
        token: 0,
        location: "localhost:8080",
        detail: context
      };
      httpRequestblocklist.open("POST", blockurl, true);
      httpRequestblocklist.setRequestHeader(
        "Content-type",
        "application/json"
      );
      httpRequestblocklist.send(JSON.stringify(blocktext));

      this.$router.push({ name: "page6", params: { id: "3" } });
    },
    async logout() {
      var blockmsg = await login.unregister();

      var blockurl = "http://localhost:6001/insert/blocklist";
      var mytime = new Date().toLocaleString('chinese', { hour12: false });
      var httpRequestblocklist = new XMLHttpRequest();
      var context = "注销评估师";
      var blocktext = {
        owner: window.web3.eth.accounts[0],
        address: "无",
        gasused: blockmsg.receipt.gasUsed,
        timestamp: mytime,
        blockhash: blockmsg.receipt.blockHash,
        blocknumber: blockmsg.receipt.blockNumber,
        transactionid: blockmsg.receipt.transactionHash,
        token: 0,
        location: "localhost:8080",
        detail: context
      };
      httpRequestblocklist.open("POST", blockurl, true);
      httpRequestblocklist.setRequestHeader(
        "Content-type",
        "application/json"
      );
      httpRequestblocklist.send(JSON.stringify(blocktext));
    },
    formatTooltip(val) {
      return (val + "%");
    },
    buytoken(row) {
      this.$prompt("请输入购买通证数量", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消"
      }).then(async ({ value }) => {
        var balance = await token.displaybalance();
        var supply = await token.displaytoken();
        if (balance == 0) balance = 1;
        var Eth_amount = (Math.pow(value / supply + 1, 2) - 1) * balance;
        Eth_amount = Math.round(Eth_amount);

        var address = row.address;
        var update_token_url =
          "http://localhost:6001/update/blocklist";
        var httpRequesttokeninfo = new XMLHttpRequest();
        var update_token_text = {
          address: address,
          token: value
        };
        httpRequesttokeninfo.open("POST", update_token_url, true);
        httpRequesttokeninfo.setRequestHeader(
          "Content-type",
          "application/json"
        );
        httpRequesttokeninfo.send(JSON.stringify(update_token_text));

        var blockmsg = await token.buy(value, Eth_amount);    //调用智能合约，并返回交易收据

        var blockurl = "http://localhost:6001/insert/blocklist";
        var mytime = new Date().toLocaleString('chinese', { hour12: false });
        var httpRequestblocklist = new XMLHttpRequest();
        var context = "购买通证：" + value;
        var blocktext = {
          owner:window.web3.eth.accounts[0],
          address: "无",
          gasused: blockmsg.receipt.gasUsed,
          timestamp: mytime,
          blockhash: blockmsg.receipt.blockHash,
          blocknumber: blockmsg.receipt.blockNumber,
          transactionid: blockmsg.receipt.transactionHash,
          token: 0,
          location: "localhost:8080",
          detail: context
        };
        httpRequestblocklist.open("POST", blockurl, true);
        httpRequestblocklist.setRequestHeader(
          "Content-type",
          "application/json"
        );
        httpRequestblocklist.send(JSON.stringify(blocktext));

        //parent.location.reload();
      });
    },
    selltoken(row) {
      this.$prompt("请输入卖出通证数量", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消"
      }).then(async ({ value }) => {
        var balance = await token.displaybalance();
        var supply = await token.displaytoken();
        if (balance == 0) balance = 1;
        var Eth_amount = (1 - Math.pow(1 - value / supply, 2)) * balance;
        Eth_amount = Math.round(Eth_amount);

        var address = row.address;
        var update_token_url =
          "http://localhost:6001/update/blocklist";
        var httpRequesttokeninfo = new XMLHttpRequest();
        var update_token_text = {
          address: address,
          token: value
        };
        httpRequesttokeninfo.open("POST", update_token_url, true);
        httpRequesttokeninfo.setRequestHeader(
          "Content-type",
          "application/json"
        );
        httpRequesttokeninfo.send(JSON.stringify(update_token_text));
        
        var blockmsg = await token.sell(value, Eth_amount);   //调用智能合约，并返回交易收据

        var blockurl = "http://localhost:6001/insert/blocklist";
        var mytime = new Date().toLocaleString('chinese', { hour12: false });
        var httpRequestblocklist = new XMLHttpRequest();
        var context = "卖出通证：" + value;
        var blocktext = {
          owner:window.web3.eth.accounts[0],
          address: "无",
          gasused: blockmsg.receipt.gasUsed,
          timestamp: mytime,
          blockhash: blockmsg.receipt.blockHash,
          blocknumber: blockmsg.receipt.blockNumber,
          transactionid: blockmsg.receipt.transactionHash,
          token: 0,
          location: "localhost:8080",
          detail: context
        };
        httpRequestblocklist.open("POST", blockurl, true);
        httpRequestblocklist.setRequestHeader(
          "Content-type",
          "application/json"
        );
        httpRequestblocklist.send(JSON.stringify(blocktext));
        
        //parent.location.reload();
      });
    }
  }
};
</script>

<style lang="scss" scoped>
#signup {
  text-align: left;

  .form {
    display: flex;
    flex-direction: column;
    margin: auto;

    .entry {
      display: flex;
      flex-direction: row-reverse;
      justify-content: left;

      label {
        margin-right: 20px;
      }

      button {
        margin-left: 20px;
      }
    }
  }

  .newForm {
    .el-form-item {
      padding-top: 20px;
    }
  }

  .car_other {
      margin-top: 10px;
      font-size: 14px;
      color: #333333;
      letter-spacing: 0;
      overflow: hidden;

      span {
        display: block;
        margin-bottom: 10px;
      }
  }
}

.imgList {
  display: flex;
  flex-direction: row;
  align-items: center;
  flex-wrap: wrap;
}

.itemImg {
  margin: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  overflow: hidden;
}

.imgList {
  display: flex;
  flex-direction: row;
  align-items: center;
  flex-wrap: wrap;
}
.itemImg {
    margin: 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    overflow: hidden;
}

.span-header{
  font-size: 18px;
  font-weight: 600;
  line-height: 30px;
}
.span-content{
  font-size: 14px;
  position:absolute;
}
.box1{
  padding: 10px;
  box-sizing: border-box;
  width: 100%
}
.basicinfo{
  display: flex;
  flex-direction: row;
  justify-content:space-between;
}
.basicinfo div{
  width: 95%;
  height: 90px;
  margin: 5px 0;
  border: 1px solid #C0C0C0;
}
.tokeninfo{
  display: flex;
  flex-direction: row;
  align-items: center;
  flex-wrap: wrap;
}
.tokeninfo div{
  width: 95%;
  overflow: hidden;
  margin: 5px 0;
  border: 1px solid #C0C0C0;
}
.tr,th,td{
  text-align:left;
}
.itemImg {
  margin: 10px;
  display: flex; 
  flex-direction: column;
  align-items: center;
  flex-wrap: hidden;
}
</style>
