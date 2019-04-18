<template>
  <div>
    <span>&nbsp;</span>
    <el-input class="filter-item dialog-search" size="small" 
        @keyup.enter.native="searchBtn" 
    　　 @change="check"
        style="width:400px;"
        placeholder="请输入评估单编号" >
        <el-button slot="append" icon="el-icon-search" @click.native="searchBtn"></el-button>
    </el-input>

    <div class="box1">
      <div class="topCar">
        <div>
          <span class="span-header">&nbsp;&nbsp;车辆信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
          <span class="span-content" style="top:195px;left:20px;">评估单编号：{{address}}</span>
          <span class="span-content" style="top:195px;left:260px;">车架号：{{Frame_number}}</span>
          <span class="span-content" style="top:195px;left:500px;">号码车牌：{{Number_plate}}</span>
          <span class="span-content" style="top:195px;left:780px;">车辆类型：{{Vehicle_type}}</span>

          <span class="span-content" style="top:230px;left:20px;">品牌型号：{{Brand_number}}</span>
          <span class="span-content" style="top:230px;left:260px;">汽车排量：{{car_displacement}}</span>
          <span class="span-content" style="top:230px;left:500px;">核定载客量：{{approval_passengers}}</span>
          <span class="span-content" style="top:230px;left:780px;">发动机编号：{{Engine_number}}</span>

          <span class="span-content" style="top:265px;left:20px;">出厂日期：{{Manufacture_date}}</span>
          <span class="span-content" style="top:265px;left:260px;">评估价值：{{Evaluation}}</span>
          <span class="span-content" style="top:265px;left:500px;">时间戳：{{Timestammp}}</span>
          <span class="span-content" style="top:265px;left:780px;">评估状态：{{Evaluation_status}}</span>
        </div>
      </div>

      <div class="topBlock">
        <div>
          <span class="span-header">&nbsp;&nbsp;区块信息</span>
          <span class="span-content" style="top:315px;left:120px;font-weight: 550;">区块数：10</span>
          <span class="span-content" style="top:315px;left:200px;font-weight: 550;">交易数：18</span>
          <span class="span-content" style="top:315px;left:280px;font-weight: 550;">IPFS哈希数：8</span>
          <span class="span-content" style="top:315px;left:400px;font-weight: 550;">用户地址：0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0</span>
          <span class="span-content" style="top:315px;left:830px;font-weight: 550;">评估师地址：0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
         
          <table class="table table-bordered table-striped text-center">
                <thead >
                    <tr>
                        <th>序号</th>
                        <th>时间戳</th>
                        <th>区块号</th>
                        <th>gas消耗</th>
                        <th>交易ID</th>
                        <th>修改内容</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for ="(user,index) in users ">
                      <td style="width:40px">{{index+1}}</td>
                      <td style="width:160px">{{user.timestamp}}</td>
                      <td style="width:60px">{{user.blockid}}</td>
                      <td style="width:80px">{{user.gasuse}}</td>
                      <td style="width:200px">{{user.transactionid}}</td>
                      <td>{{user.edit}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
      </div>

      <div class="topPhoto">
        <div>
          <span class="span-header">&nbsp;&nbsp;图片信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">

          <span class="itemImg" v-for="(item,i,index) in photo" :key="i">
            <p style="text-align:center">{{pmsg[index]}} </p> 
            <img :src="item" width="240" height="240">
          </span>

        </div>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  data() {
    return {
      address:'',
      Frame_number:'',
      Number_plate:'',
      Vehicle_type:'',
      Brand_number:'',
      car_displacement:'',
      approval_passengers:'',
      Engine_number:'',
      Manufacture_date:'',
      Evaluation:'',
      Timestammp:'',
      Evaluation_status:'',

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
      user: {'timestamp': '', 'blockid': '', 'gasuse': '','transactionid': '','edit':''},
      users: [
        {'timestamp': '2019-04-06 19:33:47', 'blockid': '1', 'gasuse': '142533','transactionid': '0xa2b72d7790e066054ad0cead86e598036f54e71161bae5b68db6d5a10dfb9a0e','edit':'添加照片'},
        {'timestamp': '2019-04-07 19:33:47', 'blockid': '5', 'gasuse': '142533','transactionid': '0xa2b72d7790e066054ad0cead86e598036f54e71161bae5b68db6d5a10dfb6a0e','edit':'将评估价值由0改为100万元'},
        {'timestamp': '2019-04-08 19:33:47', 'blockid': '6', 'gasuse': '142533','transactionid': '0xa2b72d7790e066054ad0cead86e598036f54e71161bae5b68db6d5a10dfb9a10','edit':'评估单状态：已评估改为已申诉'}
      ]
    }
  },
  created: async function() {
    var url = "http://localhost:6001/search/carinfo";
    var httpRequest = new XMLHttpRequest();

    httpRequest.open("GET", url, true);
    httpRequest.setRequestHeader("Content-type", "application/json");
    httpRequest.send();

    httpRequest.onreadystatechange = function() {
      if (httpRequest.readyState == 4 && httpRequest.status == 200) {
        var content = JSON.parse(httpRequest.responseText);
        console.log(content);
        for(var i = 0;i < content.length;i++) {
          console.log(content[i].address);
          console.log(content[i].Frame_number);
          console.log(content[i].Number_plate);
          console.log(content[i].Vehicle_type);
          console.log(content[i].Brand_number);
          console.log(content[i].Car_displacement);
          console.log(content[i].approval_passengers);
          console.log(content[i].Engine_number);
          console.log(content[i].Manufacture_date);
          console.log(content[i].Evaluation);
          console.log(content[i].Timestammp);
          console.log(content[i].Evaluation_status);
        }
      }
    };
  },
  methods: {
    check(value) {  
      let reg = /^[1-9]\d*$/;
      var _this = this;
      if (value) {
        if (new RegExp(reg).test(value) == false) {
          setTimeout(() => {
            _this.actionDataForm.studNum = '';
            _this.errorTip = true;
　　　　　　}, 500); 
        }
        else { 
  　　　　　　this.errorTip = false; 
  　　　 } 
      } 
    }
  }
}
</script>

<style>
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
    height: 150px;
    margin: 5px 0;
    border: 1px solid #C0C0C0;
  }
  .topPhoto{
    display: flex;
    flex-direction: row;
    justify-content:space-between;
  }
  .topPhoto div{
    width: 100%;
    height: 450px;
    margin: 5px 0;
    border: 1px solid #C0C0C0;
  }
  .tr,th,td{
    text-align:left;
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