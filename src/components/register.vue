<template>
  <div>
    <div class="car_other">
      <div style="width:400px" v-for="(item,i,index) in carInfo" :key="i">
        <span>{{msg[index]}}{{item}} <br> </span> 
      </div>

      <div class="imgList">
        <div class="itemImg" v-for="(item,i,index) in photo" :key="i">
          <div style="text-align:center">{{pmsg[index]}} </div> 
          <img :src="item" width="240" height="240">
        </div>
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
        photo1 : "http://localhost:5000/ipfs/Qmbhw8aGxK3wERWWUccTc5CYRkV4KbVq2fiqexYUTnTS9J",
        photo2 : "http://localhost:5000/ipfs/QmdPLwgsAtmm8sqcYKHdpKMMRN3pToMs2Ga28GdKTTYx8t",
        photo3 : "http://localhost:5000/ipfs/QmUp8xjFR1aX2h3Ne7ABos3if7CLxDRuUQ7oFWaECrVQ6b",
        photo4 : "http://localhost:5000/ipfs/Qmbhw8aGxK3wERWWUccTc5CYRkV4KbVq2fiqexYUTnTS9J",        
        photo5 : "http://localhost:5000/ipfs/QmdPLwgsAtmm8sqcYKHdpKMMRN3pToMs2Ga28GdKTTYx8t",
        photo6 : "http://localhost:5000/ipfs/QmUp8xjFR1aX2h3Ne7ABos3if7CLxDRuUQ7oFWaECrVQ6b",
        photo7 : "http://localhost:5000/ipfs/Qmbhw8aGxK3wERWWUccTc5CYRkV4KbVq2fiqexYUTnTS9J",
        photo8 : "http://localhost:5000/ipfs/QmdPLwgsAtmm8sqcYKHdpKMMRN3pToMs2Ga28GdKTTYx8t"
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
        var Eth_amount = (Math.pow(200 / supply + 1, 2) - 1) * balance;
        Eth_amount = Math.round(Eth_amount);
        await alert("答题正确，评估师注册需购买200通证押金,共需支付: " + Eth_amount + " wei");

        var commission = 200 - this.scale;
        console.log(commission);
        await login.registertest(200, commission, Eth_amount);
        this.$router.push({ name: "page6", params: { id: "3" } });
        // this.$message({
        //   type: "success",
        //   message: "评估价格:" + value
        // });
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
</style>
