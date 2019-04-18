<template>
  <div>
    <div>
      <el-form :inline="true" :model="formInline" class="demo-form-inline">
        <!-- <el-form-item>
          <el-select v-model="formInline.region" placeholder="请输入用户类型">
            <el-option label="普通账号" value="user"></el-option>
            <el-option label="评估师账户" value="Appraiser"></el-option>
          </el-select>
        </el-form-item>-->
        <el-form-item>
          <el-button type="primary" @click="onSubmit">
            注册评估师
            <br>
          </el-button>
          <el-button type="primary" @click="logout">注销</el-button>
        </el-form-item>

        <el-form-item>
          <el-slider v-model="value" :format-tooltip="formatTooltip" :step="5" show-stops></el-slider>
          <el-button type="primary" @click="setparameter">修改订单提成</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import token from "@/js/token";
import login from "@/js/login";

export default {
  data() {
    return {
      formInline: {
        user: "",
        region: ""
      },
      value: 50
    };
  },
  created: async function() {
    await token.init_token();
    await login.init_user();
  },
  methods: {
    async onSubmit() {
      // var tmp = await login.registertest(1, 1, 1);
      // var mytime=new Date().toLocaleString();
      
      // console.log(tmp);
      // console.log(mytime);
      // console.log(tmp.receipt.blockNumber);
      // console.log(tmp.receipt.gasUsed);
      // console.log(tmp.tx);

      // var url = "http://localhost:6001/insert/blockinfo";
      // var httpRequest = new XMLHttpRequest();
      // var text = 'aabbcc';
      // var objtext = { 'address':text,'timestamp':'224','blocknumber':'333','transactionid':'444','detail':'555' };

      // httpRequest.open("POST", url, true);
      // httpRequest.setRequestHeader("Content-type", "application/json");
      // httpRequest.send(JSON.stringify(objtext));

      this.$router.push({ name: "register", params: { id: "1" } });
    },
    async logout() {
      var url = "http://localhost:6001/search/carinfo";
      $.get(url,function(data){  
        console.log(data);
       });
      // var httpRequest = new XMLHttpRequest();

      // httpRequest.open("GET", url, true);
      // httpRequest.setRequestHeader("Content-type", "application/json");
      // httpRequest.send();

      // httpRequest.onreadystatechange = function() {
      //   if (httpRequest.readyState == 4 && httpRequest.status == 200) {
      //     var content = JSON.parse(httpRequest.responseText);
      //     console.log(content);
      //     for(var i = 0;i < content.length;i++) {
      //       console.log(content[i].address);
      //       console.log(content[i].Frame_number);
      //       console.log(content[i].Number_plate);
      //       console.log(content[i].Vehicle_type);
      //       console.log(content[i].Brand_number);
      //       console.log(content[i].Car_displacement);
      //       console.log(content[i].approval_passengers);
      //       console.log(content[i].Engine_number);
      //       console.log(content[i].Manufacture_date);
      //       console.log(content[i].Evaluation);
      //       console.log(content[i].Timestammp);
      //       console.log(content[i].Evaluation_status);
      //     }
      //   }
      // };

      // login.unregister(function(error,result){
      //   if(!error)
      //     console.log(result);
      //   else
      //     console.log(error);
      // })

      // web3.eth.getBlockNumber(function(error,result){
      //   if(!error)
      //     console.log(JSON.stringify(result));
      //   else
      //     console.log(error);
      // })
    },
    async setparameter() {
      // this.$prompt("请输入报价", "提示", {
      //   confirmButtonText: "确定",
      //   cancelButtonText: "取消"
      // }).then(async ({ value }) => {
      //   await login.Enter_quote(value);
      // });
      var commission = 200 - this.value;
      console.log(commission);
      await login.Enter_quote(commission);
    },
    formatTooltip(val) {
      return val + "%";
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1,
h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
