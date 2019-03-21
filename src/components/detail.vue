<template>
  <div>
    <div class="car_other">
      <div style="width:280px" v-for="(item,i,index) in carInfo" :key="i">
        <span>{{msg[index]}}{{item}} <br> </span> 
      </div>
      <div style="imgBox" v-for="(item,i,index) in photo" :key="i">
        <span style="text-align:center">{{pmsg[index]}} <br> </span> 
        <img :src="item" width="200" height="200">
      </div>
    </div>
  </div>
</template>


<script>
import Detail from "@/js/detail";

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
        "评估价值：",
        "时间戳：",
        "评估状态："

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
        Frame_number:"",
        Number_plate:"",
        Vehicle_type:"",
        Brand_number:"",
        Engine_number:"",
        Manufacture_date:"",
        Evaluation:"",
        Timestammp:"",
        Evaluation_status:""
      },
      photo : {
        photo1:"",
        photo2:"",
        photo3:"",
        photo4:"",
        photo5:"",
        photo6:"",
        photo7:"",
        photo8:""
      }
      
    };
  },
  created: async function() {
    await Detail.init_user();

    var id = this.$route.params.userid;
    var state = await Detail.display(id, 9);
    if(state == "0") state = "待评估";
    else if(state == "1") state = "已评估";
    else if(state == "2") state = "已申诉";
    else if(state == "3") state = "申诉完成";
    else if(state == "4") state = "已关闭";

 
    this.carInfo.Frame_number = await Detail.display(id, 1);
    this.carInfo.Number_plate = await Detail.display(id, 2);
    this.carInfo.Vehicle_type = await Detail.display(id, 3);
    this.carInfo.Brand_number = await Detail.display(id, 4);
    this.carInfo.Engine_number = await Detail.display(id, 5);
    this.carInfo.Manufacture_date = await Detail.display(id, 6);
    this.carInfo.Evaluation = (await Detail.display(id, 7)) + "元";
    this.carInfo.Timestammp = await Detail.display(id, 8);

    this.carInfo.Evaluation_status = state;

    this.photo.photo1 = await Detail.display(id, 10);
    this.photo.photo2 = await Detail.display(id, 11);
    this.photo.photo3 = await Detail.display(id, 12);
    this.photo.photo4 = await Detail.display(id, 13);
    this.photo.photo5 = await Detail.display(id, 14);
    this.photo.photo6 = await Detail.display(id, 15);
    this.photo.photo7 = await Detail.display(id, 16);
    this.photo.photo8 = await Detail.display(id, 17);

    console.log(await Detail.display(id, 10));
    console.log(await Detail.display(id, 11));
    console.log(await Detail.display(id, 12));
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

  .imgBox {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    flex-wrap: wrap;
  }
}
</style>
