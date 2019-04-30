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

      // var httpRequest1 = new XMLHttpRequest();
      // var urldemo1 = "http://localhost:6001/insert/photoinfo";
      // var objtext1 = {
      //   'address':'aaa',
      //   'photo1':'1',
      //   'photo2':'2',
      //   'photo3':'3',
      //   'photo4':'4',
      //   'photo5':'5',
      //   'photo6':'6',
      //   'photo7':'7',
      //   'photo8':'8'
      // };      

      // httpRequest1.open("POST", urldemo1, true);
      // httpRequest1.setRequestHeader("Content-type", "application/json");
      // httpRequest1.send(JSON.stringify(objtext1));

      this.$router.push({ name: "register", params: { id: "1" } });
    },
    async logout() {
      // var urldemo = "http://localhost:6001/search/blocklist";
      // const response = await fetch(urldemo);
      // const content = await response.json();
      var mydate = new Date().toLocaleString('chinese', { hour12: false });
      console.log(mydate);

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
