<template>
  <div>
    <span>&nbsp;</span>
    <el-input
      placeholder="请输入评估单编号"
      v-model="input"
      style="width:400px;"
      clearable>
    </el-input>
    <el-button type="primary" @click="getInputValue">查询</el-button>

    <div class="box1"  v-if=flag>
      <div class="topCar">
        <div>
          <span class="span-header">&nbsp;&nbsp;车辆信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
          <span class="span-content" style="top:205px;left:20px;">评估单编号：{{address}}</span>
          <span class="span-content" style="top:205px;left:260px;">车架号：{{Frame_number}}</span>
          <span class="span-content" style="top:205px;left:500px;">号码车牌：{{Number_plate}}</span>
          <span class="span-content" style="top:205px;left:780px;">车辆类型：{{Vehicle_type}}</span>

          <span class="span-content" style="top:240px;left:20px;">品牌型号：{{Brand_number}}</span>
          <span class="span-content" style="top:240px;left:260px;">汽车排量：{{Car_displacement}}</span>
          <span class="span-content" style="top:240px;left:500px;">核定载客量：{{approval_passengers}}</span>
          <span class="span-content" style="top:240px;left:780px;">发动机编号：{{Engine_number}}</span>

          <span class="span-content" style="top:275px;left:20px;">出厂日期：{{Manufacture_date}}</span>
          <span class="span-content" style="top:275px;left:260px;">评估价值：{{Evaluation}}万元</span>
          <span class="span-content" style="top:275px;left:500px;">时间戳：{{Timestammp}}</span>
          <span class="span-content" style="top:275px;left:780px;">评估状态：{{Evaluation_status}}</span>
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

      <div class="topBlock">
        <div>
          <span class="span-header">&nbsp;&nbsp;区块信息</span>
          <span class="span-content" style="top:920px;left:120px;font-weight: 550;">区块数：{{blocktransaction}}</span>
          <span class="span-content" style="top:920px;left:200px;font-weight: 550;">交易数：{{blocktransaction}}</span>
          <span class="span-content" style="top:920px;left:280px;font-weight: 550;">IPFS哈希数：8</span>
          <span class="span-content" style="top:920px;left:400px;font-weight: 550;">用户地址：{{useraddress}}</span>
          <span class="span-content" style="top:920px;left:830px;font-weight: 550;">评估师地址：{{workaddress}}</span>
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
                  <td style="width:150px">{{user.timestamp}}</td>
                  <td style="width:60px">{{user.blockid}}</td>
                  <td style="width:70px">{{user.gasuse}}</td>
                  <td style="width:200px">{{user.transactionid}}</td>
                  <td >{{user.edit}}</td>
                </tr>
            </tbody>
          </table>
        </div>
      </div> 
    </div>
  </div>
</template>

<script>
import Demo from "@/js/create";

export default {
  data() {
    return {
      address:'',
      Frame_number:'',
      Number_plate:'',
      Vehicle_type:'',
      Brand_number:'',
      Car_displacement:'',
      approval_passengers:'',
      Engine_number:'',
      Manufacture_date:'',
      Evaluation:'',
      Timestammp:'',
      Evaluation_status:'',
      blocktransaction:'',
      useraddress:'',
      workaddress:'',
      input:'',
      flag:'',

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
      photo : {
        photo1 : '',
        photo2 : '',
        photo3 : '',
        photo4 : '',        
        photo5 : '',
        photo6 : '',
        photo7 : '',
        photo8 : ''
      },
      user: {'timestamp': '', 'blockid': '', 'gasuse': '','transactionid': '','edit':''},
      users: []
    }
  },
  created: async function() {
    await Demo.init_user();

  },
  methods: {
    async getInputValue() {
      var carurl = 'http://localhost:6001/search/carinfo?key=' + this.input;
      var responsecarinfo = await fetch(carurl);
      var carinfo = await responsecarinfo.json();

      try{
        if(carinfo[0].address == this.input) {
          this.flag = 1;
        }
        else {
          this.flag = 1;
          return ;
        }
      }
      catch(err){
        this.flag = 0;
        return ;
      }
      
      this.address = carinfo[0].address;
      this.Frame_number = carinfo[0].Frame_number;
      this.Number_plate = carinfo[0].Number_plate;
      this.Vehicle_type = carinfo[0].Vehicle_type;
      this.Brand_number = carinfo[0].Brand_number;
      this.Car_displacement = carinfo[0].Car_displacement;
      this.approval_passengers = carinfo[0].approval_passengers;
      this.Engine_number = carinfo[0].Engine_number;
      this.Manufacture_date = carinfo[0].Manufacture_date;
      this.Evaluation = carinfo[0].Evaluation;
      this.Timestammp = carinfo[0].Timestammp;
      this.Evaluation_status = carinfo[0].Evaluation_status;

      var ipfsurl = 'http://localhost:6001/search/Ipfshashlist?key=address&param=' + this.input;
      var responseipfsinfo = await fetch(ipfsurl);
      var ipfsinfo = await responseipfsinfo.json();
      
      this.photo.photo1 = "http://localhost:5000/ipfs/" + ipfsinfo[0].ipfshash;
      this.photo.photo2 = "http://localhost:5000/ipfs/" + ipfsinfo[1].ipfshash;
      this.photo.photo3 = "http://localhost:5000/ipfs/" + ipfsinfo[2].ipfshash;
      this.photo.photo4 = "http://localhost:5000/ipfs/" + ipfsinfo[3].ipfshash;
      this.photo.photo5 = "http://localhost:5000/ipfs/" + ipfsinfo[4].ipfshash;
      this.photo.photo6 = "http://localhost:5000/ipfs/" + ipfsinfo[5].ipfshash;
      this.photo.photo7 = "http://localhost:5000/ipfs/" + ipfsinfo[6].ipfshash;
      this.photo.photo8 = "http://localhost:5000/ipfs/" + ipfsinfo[7].ipfshash;
      

      var blockurl = 'http://localhost:6001/search/blocklist?key=address&param=' + this.input;
      var responseblockinfo = await fetch(blockurl);
      var blockinfo = await responseblockinfo.json();

      this.blocktransaction = blockinfo.length;

      var str;
      var num = blockinfo.length;
      var result = "[";

      for(var i = 0;i<num;i++) {
        str =
          '{"timestamp":"' + blockinfo[i].timestamp             +
          '","blockid":"'  + blockinfo[i].blocknumber           +
          '","gasuse":"'  + blockinfo[i].gasused                +
          '","transactionid":"'  + blockinfo[i].transactionid   +
          '","edit":"'  + blockinfo[i].detail                   +        
          '"}';

        result = result + str;
        if (i < num - 1) result = result + ",";
      }
      result = result + "]";

      this.users = JSON.parse(result);

      this.useraddress = await Demo.getcreator(this.input);
      this.workaddress = await Demo.getassessor(this.input);
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