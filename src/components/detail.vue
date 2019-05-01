<template>
  <div class="box1">
      <div class="topCar">
        <div>
          <span class="span-header">&nbsp;&nbsp;车辆信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
          <span class="span-content" style="top:160px;left:20px;">车架号：{{carInfo.Frame_number}}</span>
          <span class="span-content" style="top:160px;left:260px;">号码车牌：{{carInfo.Number_plate}}</span>
          <span class="span-content" style="top:160px;left:500px;">车辆类型：{{carInfo.Vehicle_type}}</span>
          <span class="span-content" style="top:160px;left:780px;">品牌型号：{{carInfo.Brand_number}}</span>

          <span class="span-content" style="top:195px;left:20px;">汽车排量：{{carInfo.car_displacement}}</span>
          <span class="span-content" style="top:195px;left:260px;">核定载客量：{{carInfo.approval_passengers}}</span>
          <span class="span-content" style="top:195px;left:500px;">发动机编号：{{carInfo.Engine_number}}</span>
          <span class="span-content" style="top:195px;left:780px;">出厂日期：{{carInfo.Manufacture_date}}</span>

          <span class="span-content" style="top:230px;left:20px;">评估价值：{{carInfo.Evaluation}}</span>
          <span class="span-content" style="top:230px;left:260px;">时间戳：{{carInfo.Timestammp}}</span>
          <span class="span-content" style="top:230px;left:500px;">评估状态：{{carInfo.Evaluation_status}}</span>
          <span class="span-content" style="top:230px;left:780px;" v-if="tickresult > 0">当前仲裁进度：{{tickresult}}/5</span>
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
  </div>
</template>


<script>
import Detail from "@/js/detail";

export default {
  data() {
    return {
      pmsg: [
        "左前45°",
        "主驾驶仓",
        "仪表台",
        "天窗",
        "后排座椅",
        "中控台",
        "右后45°",
        "副驾驶仓"
      ],
      carInfo: {
        Frame_number: "",
        Number_plate: "",
        Vehicle_type: "",
        Brand_number: "",
        car_displacement:"",
        approval_passengers:"",
        Engine_number: "",
        Manufacture_date: "",
        Evaluation: "",
        Timestammp: "",
        Evaluation_status: ""
      },
      photo: {
        photo1: "",
        photo2: "",
        photo3: "",
        photo4: "",
        photo5: "",
        photo6: "",
        photo7: "",
        photo8: ""
      },
      tickresult: ""
    };
  },
  created: async function() {
    await Detail.init_user();

    var id = this.$route.params.userid;
    var state = await Detail.displayinfo(id, 11);
    if (state == "0") state = "待评估";
    else if (state == "1") state = "已评估";
    else if (state == "2") state = "已申诉";
    else if (state == "3") state = "申诉完成";
    else if (state == "4") state = "已关闭";

    this.carInfo.Frame_number = await Detail.displayinfo(id, 1);
    this.carInfo.Number_plate = await Detail.displayinfo(id, 2);
    this.carInfo.Vehicle_type = await Detail.displayinfo(id, 3);
    this.carInfo.Brand_number = await Detail.displayinfo(id, 4);
    this.carInfo.car_displacement = await Detail.displayinfo(id, 5);
    this.carInfo.approval_passengers = await Detail.displayinfo(id, 6);
    this.carInfo.Engine_number = await Detail.displayinfo(id, 7);
    this.carInfo.Manufacture_date = await Detail.displayinfo(id, 8);
    this.carInfo.Evaluation = (await Detail.displayvalue(id)) + "万元";
    this.carInfo.Timestammp = await Detail.displayinfo(id, 10);

    this.carInfo.Evaluation_status = state;

    this.photo.photo1 = await Detail.displayinfo(id, 12);
    this.photo.photo2 = await Detail.displayinfo(id, 13);
    this.photo.photo3 = await Detail.displayinfo(id, 14);
    this.photo.photo4 = await Detail.displayinfo(id, 15);
    this.photo.photo5 = await Detail.displayinfo(id, 16);
    this.photo.photo6 = await Detail.displayinfo(id, 17);
    this.photo.photo7 = await Detail.displayinfo(id, 18);
    this.photo.photo8 = await Detail.displayinfo(id, 19);

    this.tickresult = await Detail.appealeschedule(id);
  },
  methods: {}
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
    height: 150px;
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
