<template>
  <div>
    <p>第一步: <br> </p>
    <el-form ref="form" :model="form" label-width="100px" size="medium">
      <el-form-item style="width:400px;" label="车架号">
        <el-input v-model="form.Frame"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="品牌型号">
        <el-input v-model="form.Brand"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="号码车牌">
        <el-input v-model="form.Number"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="汽车排量(L)">
        <el-input v-model="form.displacement"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="核定载客量">
        <el-input v-model="form.passengers"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="发动机编号">
        <el-input v-model="form.Engine"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="车辆类型">
        <el-select v-model="form.Vehicle" placeholder="请选择使用性质">
          <el-option label="营运" value="营运"></el-option>
          <el-option label="非营运" value="非营运"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item style="width:535px;" label="出厂日期">
        <el-col :span="11">
          <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>
        </el-col>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="onSubmit">下一步</el-button>
        <el-button @click="onCancel">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import Demo from "@/js/create";

export default {
  data() {
    return {
      activeIndex2: "1",
      form: {
        Brand: "",
        Number: "",
        Frame: "",
        Engine: "",
        Vehicle: "",
        date1: "",
        displacement:"",
        passengers:""
      }
    };
  },
  created: async function() {
    await Demo.init_user();
  },
  methods: {
    async onCancel() {
      this.$router.push({ name: "page1", params: { id: "2" } });
    },
    async onSubmit() {
      var valuation_number = await Demo.backordernumber();
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
        (Array(5).join(0) + valuation_number).slice(-5);

      var blockmsg = await Demo.addvaluation(
        this.form.Frame.toString(),
        this.form.Number.toString(),
        this.form.Vehicle.toString(),
        this.form.Brand.toString(),          
        this.form.displacement.toString(),
        this.form.passengers.toString(),
        this.form.Engine.toString(),
        this.form.date1.toLocaleDateString(),
        new Date().toLocaleString(),
        valuation_number
      );

      var blockurl = "http://localhost:6001/insert/blocklist";
      var mytime= new Date().toLocaleString('chinese', { hour12: false });
      var httpRequest = new XMLHttpRequest();
      var context = '创建评估单编号：'+valuation_number;
      var blocktext = {
        'owner':window.web3.eth.accounts[0],
        'address':valuation_number,
        'gasused':blockmsg.receipt.gasUsed,
        'timestamp':mytime,
        'blockhash':blockmsg.receipt.blockHash,
        'blocknumber':blockmsg.receipt.blockNumber,
        'transactionid':blockmsg.receipt.transactionHash,
        'token':0,
        'location':'localhost:8080',
        'detail':context
        };

      httpRequest.open("POST", blockurl, true);
      httpRequest.setRequestHeader("Content-type", "application/json");
      httpRequest.send(JSON.stringify(blocktext));

      this.$router.push({ name: "create2", params: { userid: valuation_number } });  
    }
  }
};
</script>

