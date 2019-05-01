<template>
  <div class="box1">
      <div class="topCar">
        <div>
          <span class="span-header">&nbsp;&nbsp;基本信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
          <span class="span-content" style="top:160px;left:20px;">车架号：{{carInfo.Frame_number}}</span>
          <span class="span-content" style="top:160px;left:260px;">号码车牌：{{carInfo.Number_plate}}</span>
          <span class="span-content" style="top:160px;left:500px;">车辆类型：{{carInfo.Vehicle_type}}</span>
          <span class="span-content" style="top:160px;left:780px;">发动机编号：{{carInfo.Engine_number}}</span>

          <span class="span-content" style="top:195px;left:20px;">品牌型号：{{carInfo.Brand_number}}</span>
          <span class="span-content" style="top:195px;left:500px;">时间戳：{{carInfo.Timestammp}}</span>
          <span class="span-content" style="top:195px;left:780px;">出厂日期：{{carInfo.Manufacture_date}}</span>
        </div>
      </div>

      <div class="topPhoto">
        <div>
          <span class="span-header">&nbsp;&nbsp;图片信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">

          <viewer class = "duqiang" style="width: 100%;border: 0px">
            <span class="itemImg" v-for="(item,i,index) in photo" :key="i">
              <p style="text-align:center">{{pmsg[index]}} </p> 
              <img :src="item" width="232" height="232">
            </span>
          </viewer>
        </div>
      </div>

    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <span>设置订单提成 : {{scale}}% （提成过高可能会影响竞争力）</span>
        <el-slider v-model="scale" :format-tooltip="formatTooltip" :step="5"  show-stops></el-slider>
        <el-button type="primary" @click="setparameter">答题</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>


<script>
import token from "@/js/token";
import login from "@/js/login";

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
      scale: 50
    };
  },
  created: async function() {
    await token.init_token();
    await login.init_user();
  },
  methods: {
    setparameter() { 
      this.$prompt("请输入评估价格", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
      }).then(async ({ value }) => {
        var balance = await token.displaybalance();
        var supply = await token.displaytoken();
        if (balance == 0) balance = 1;
        var Eth_amount = Math.round((Math.pow(200 / supply + 1, 2) - 1) * balance);
        var commission = 200 - this.scale;

        var blockmsg = await login.registertest(200, commission, Eth_amount);

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
      });
    },
    formatTooltip(val) {
      return (val + "%");
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
  .topCar{
    display: flex;
    flex-direction: row;
    justify-content:space-between;
  }
  .topCar div{
    width: 80%;
    height: 100px;
    margin: 5px 0;
    border: 1px solid #C0C0C0;
  }
  .topBlock{
    display: flex;
    flex-direction: row;
    justify-content:space-between;
  }
  .topBlock div{
    width: 100%;
    overflow: hidden;
    margin: 5px 0;
    border: 1px solid #C0C0C0;
  }
  .topPhoto{
    display: flex;
    flex-direction: row;
    align-items: center;
    flex-wrap: wrap;
  }
  .duqiang{
    display: flex;
    flex-direction: row;
    align-items: center;
    flex-wrap: wrap;
  }
  .topPhoto div{
    width: 80%;
    overflow: hidden;
    margin: 0px 0;
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
