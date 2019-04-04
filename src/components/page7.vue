<template>
  <div>
    <span>&nbsp;</span>
    <el-input class="filter-item dialog-search" size="small" 
        @keyup.enter.native="searchBtn" 
        v-model.lazy.trim="searchKey" 
    　　 @change="check"
        style="width:400px;"
        placeholder="请输入评估单编号" >
        <el-button slot="append" icon="el-icon-search" @click.native="searchBtn"></el-button>
    </el-input>

    <div class="box1">
      <div class="topCar">
        <div>
          <span class="span">&nbsp;&nbsp;车辆信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
        </div>
      </div>
      <div class="topBlock">
        <div>
          <span class="span">&nbsp;&nbsp;区块信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
        </div>
      </div>
      <div class="topPhoto">
        <div>
          <span class="span">&nbsp;&nbsp;图片信息</span>
          <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:98%">
        </div>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  data() {
    return {
      input10: ''
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
  .span{
    font-size: 18px;
    font-weight: 500;
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
    width: 80%;
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
  
</style>