<template>
  <div id="app">
    <!-- <img src="./assets/logo.png"> -->
    <div class="header">
      <div>&nbsp;&nbsp;基于区块链的汽车估值系统</div>
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
      <el-menu-item index="/page3">支付清算</el-menu-item>
      <el-menu-item index="/page4">信息评估</el-menu-item>
      <el-menu-item index="/page5">评估仲裁</el-menu-item>
      <el-menu-item index="/page6">评估师管理</el-menu-item>
    </el-menu>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app'
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
.header{
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  background-color: rgb(171, 170, 206);
  color:aliceblue;
  font-size: 28px;
}
</style>
