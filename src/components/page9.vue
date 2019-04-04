<template>
  <div class="box">
    <div class="topList">
      <div>
        <span class="spanhistory">&nbsp;&nbsp;23,104<br></span>
        <span class="spanhistory">&nbsp;&nbsp;区块数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
      <div>
        <span class="spanhistory">&nbsp;&nbsp;10,104<br></span>
        <span class="spanhistory">&nbsp;&nbsp;交易数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
      <div>
        <span class="spanhistory">&nbsp;&nbsp;96<br></span>
        <span class="spanhistory">&nbsp;&nbsp;账户数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
      <div>
        <span class="spanhistory">&nbsp;&nbsp;26.352<br></span>
        <span class="spanhistory">&nbsp;&nbsp;IPFS哈希数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
    </div>
    <div class="bottomList">
      <div>
        <span class="spanhistory">&nbsp;&nbsp;最新区块<br></span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
        <span>&nbsp;&nbsp;区块高度 # </span>
        <br>
        <span>&nbsp;&nbsp;生产时间： </span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
      </div>

      <div>
        <span class="spanhistory">&nbsp;&nbsp;最新交易<br></span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
        <span>&nbsp;&nbsp;区块 ID： </span>
        <br>
        <span>&nbsp;&nbsp;交易 ID： </span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
      </div>

      <div>
        <span class="spanhistory">&nbsp;&nbsp;最新哈希<br></span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
        <span>&nbsp;&nbsp;图片哈希： </span>
        <br>
        <span>&nbsp;&nbsp;关联区块： </span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
      </div>
    </div>
  </div>
</template>

<script>
import Create from "@/js/create";
import Eva from "@/js/evaluate";

var tmp;

export default {

};
</script>

<style>
  .spanhistory{
    font-size: 20px;
    font-weight: 500;
    line-height:40px; 
  }
  .box{
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
  }
  .topList{
    display: flex;
    flex-direction: row;
    justify-content:space-between;
    text-align: left;
  }
  .topList div{
    width: 22%;
    height: 150px;
    margin: 10px 0;
    border: 1px solid gray;
  }
  .bottomList{
    display: flex;
    flex-direction: row;
    justify-content:space-between;
    text-align: left;
  }
  .bottomList div{
    width: 32%;
    height: 500px;
    border: 1px solid gray;
  }
</style>
<!-- Add "scoped" attribute to limit CSS to this component only -->