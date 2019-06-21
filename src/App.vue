<template>
  <div id="app">
    <div class="header1">
      <el-button type="text" style="font-size: 24px;color:aliceblue;" @click="back">&nbsp;&nbsp;基于区块链的汽车评估服务平台</el-button>
      <div classs="header2">
        <span style="font-size: 16px;color:aliceblue;">当前平台信誉值：{{credit}}</span>
        <el-button type="primary" @click="personalmsg">个人信息<br></el-button>
      </div>
      
    </div>
    <el-menu
      class="el-menu-demo"
      mode="horizontal"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b"
      router
    >
      <el-menu-item index="/">信息提交</el-menu-item>
      <el-menu-item index="/page2">评估申诉</el-menu-item>
      <el-menu-item index="/page4">信息评估</el-menu-item>
      <el-menu-item index="/page5">评估仲裁</el-menu-item>
      <el-menu-item index="/page7">订单检索</el-menu-item>
      <el-menu-item index="/page8">评估排行</el-menu-item>
      <el-menu-item index="/page9">区块历史</el-menu-item>
    </el-menu>
    <router-view></router-view>
  </div>
</template>

<script>
import token from "@/js/token";

export default {
  data() {
    return {
      credit:{}
    }
  },
  created: async function() {
    await token.init_token();
    this.credit = await token.displaytoken();
  },
  methods: {
    async tiaoshi() {
      this.$router.push({name: 'page6',params:{ id:'1'}});
    },
    async back() {
      this.$router.push({name: 'page1',params:{ id:'1'}});
    },
    async personalmsg() {
      this.$router.push({name: 'personinfo',params:{ id:'1'}});
    }
  }
}
</script>

<style>
*{
  margin: 0;
  padding: 0;
}
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: left;
  color: #2c3e50;
}
.header1{
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  background-color: rgb(171, 170, 206);
  color:aliceblue;
  font-size: 28px;
}
.header2{
  justify-content: flex-end;
}
</style>
