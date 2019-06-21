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
              <img :src="item" width="232" height="232">
              <p style="text-align:center">{{pmsg[index]}} </p>               
            </span>
          </viewer>
        </div>
      </div>

    <el-form :inline="true" class="demo-form-inline">
      <el-form-item>
        <el-button type="primary" @click="setparameter">第二题答题</el-button>
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
        "左前45°",
        "主驾驶舱",
        "仪表台",
        "天窗",
        "后排座椅",
        "中控台",
        "右后45°",
        "副驾驶舱"
      ],
      carInfo : {
        Frame_number:"LVGBJE235JG512779",
        Number_plate:"京A 00002",
        Vehicle_type:"非营运",
        Brand_number:"丰田YARiS L 致享2017款 1.5E CVT魅动版",
        Engine_number:"CWW006078",
        Manufacture_date:"2019-05-06",
        Timestammp:"2019-05-06 12:00:00"
      },
      photo : {
        photo1 : "http://localhost:5000/ipfs/QmQrey42N5niWuGDfrYUiVC4EWG4DX36x3dXJyBfinJKoX",
        photo2 : "http://localhost:5000/ipfs/QmNrCbzhYFEU8znPLXTzfh8a1Z5bx5Aoq3SEYBBs6iLfPx",
        photo3 : "http://localhost:5000/ipfs/QmSY759S7WW3wLK4rVVYgiyVwzMqv2DikpYEibsh2qLVYR",
        photo4 : "http://localhost:5000/ipfs/QmZkV9D3tYUJ9GZgv77oNBRtrHb1iZK8ftmsiMnJzgWMDv",        
        photo5 : "http://localhost:5000/ipfs/Qmeb7MLawJZdRm9wNn3xde9j86WEQL1c1uNnVoMtN6QUZF",
        photo6 : "http://localhost:5000/ipfs/QmPGrPYh946Em8gsmdJdwjEXoi5kzWzNuXi7bcyT8JRk9k",
        photo7 : "http://localhost:5000/ipfs/QmPGrPYh946Em8gsmdJdwjEXoi5kzWzNuXi7bcyT8JRk9k",
        photo8 : "http://localhost:5000/ipfs/Qma5DbHQXx3yM1bh5cj3yoWJ17fSkE7z2aDJPsbEhpuxeP"
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
        if(value > 100 && value < 120) {
          this.$router.push({ name: "register3", params: { id: "3" } });
        }
        else {
          this.$message({type: 'success',message: '回答错误'});
          this.$router.push({ name: "personinfo", params: { id: "3" } });
        }
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
