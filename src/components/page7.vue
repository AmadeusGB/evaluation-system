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
      <div class="topCar" :data="tableData">
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
          <span class="span-content" style="top:315px;left:200px;font-weight: 550;">交易数：8</span>
          <span class="span-content" style="top:315px;left:280px;font-weight: 550;">IPFS哈希数：8</span>
          <span class="span-content" style="top:315px;left:400px;font-weight: 550;">用户地址：0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0</span>
          <span class="span-content" style="top:315px;left:830px;font-weight: 550;">评估师地址：0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
         
          <table class="table table-bordered table-striped text-center">
                <thead >
                    <tr>
                        <th>序号</th>
                        <th>时间戳</th>
                        <th>交易区块号</th>
                        <th>交易ID</th>
                        <th>修改内容</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for ="(user,index) in users ">
                      <td style="width:40px">{{index+1}}</td>
                      <td style="width:120px">{{user.name}}</td>
                      <td style="width:100px">{{user.age}}</td>
                      <td style="width:590px">{{user.school}}</td>
                      <td>{{user.edit}}</td>
                    </tr>
                    <tr>
                      <td></td>
                      <td><span type="text"  id="name" /></td>
                      <td><span type="text" id="age" /></td>
                      <td><span type="text" id="school"/></td>
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
      address:'2019041000001',
      Frame_number:'12345678901234567',
      Number_plate:'京A 00001',
      Vehicle_type:'非营运',
      Brand_number:'宝马X5',
      car_displacement:'1.6L',
      approval_passengers:'6人',
      Engine_number:'20180410',
      Manufacture_date:'2011-04-08',
      Evaluation:'100万元',
      Timestammp:'2019-04-08 19:33:47',
      Evaluation_status:'已评估',

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
      user: {'name': '', 'age': '', 'school': '','edit':''},
      users: [
        {'name': '1554717684', 'age': '1', 'school': '0xa2b72d7790e066054ad0cead86e598036f54e71161bae5b68db6d5a10dfb9a0e','edit':'添加照片'},
        {'name': '1554717784', 'age': '5', 'school': '0xa2b72d7790e066054ad0cead86e598036f54e71161bae5b68db6d5a10dfb6a0e','edit':'将评估价值由0改为100万元'},
        {'name': '1554717620', 'age': '6', 'school': '0xa2b72d7790e066054ad0cead86e598036f54e71161bae5b68db6d5a10dfb9a10','edit':'评估单状态：已评估改为已申诉'}
      ]
    }
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