<template>
  <div class="box">
    <div class="topList">
      <div>
        <span class="spanhistory">&nbsp;&nbsp;{{blocknumber}}<br></span>
        <span class="spanhistory">&nbsp;&nbsp;区块数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button @click="checkblock()" type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
      <div>
        <span class="spanhistory">&nbsp;&nbsp;{{transactionnumber}}<br></span>
        <span class="spanhistory">&nbsp;&nbsp;交易数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button @click="checktransaction()" type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
      <div>
        <span class="spanhistory">&nbsp;&nbsp;{{accountnumber}}<br></span>
        <span class="spanhistory">&nbsp;&nbsp;账户数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button @click="checkaccount()" type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
      <div>
        <span class="spanhistory">&nbsp;&nbsp;{{ipfshashnumber}}<br></span>
        <span class="spanhistory">&nbsp;&nbsp;IPFS哈希数</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:92%">
        <span><br>&nbsp;</span>
        <el-button @click="checkipfs()" type="primary" round style="width:100px;height:40px;">查看</el-button>
      </div>
    </div>
    <div class="bottomList">
      <div>
        <span class="spanhistory">&nbsp;&nbsp;最新区块<br></span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块高度 #{{Leaderboard[0].blockhigh}}</span>
        <br>
        <span>&nbsp;&nbsp;生产时间： {{Leaderboard[0].timestamp}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块高度 #{{Leaderboard[1].blockhigh}}</span>
        <br>
        <span>&nbsp;&nbsp;生产时间： {{Leaderboard[1].timestamp}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块高度 #{{Leaderboard[2].blockhigh}}</span>
        <br>
        <span>&nbsp;&nbsp;生产时间： {{Leaderboard[2].timestamp}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块高度 #{{Leaderboard[3].blockhigh}}</span>
        <br>
        <span>&nbsp;&nbsp;生产时间： {{Leaderboard[3].timestamp}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块高度 #{{Leaderboard[4].blockhigh}}</span>
        <br>
        <span>&nbsp;&nbsp;生产时间： {{Leaderboard[4].timestamp}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

      </div>

      <div>
        <span class="spanhistory">&nbsp;&nbsp;最新交易<br></span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
        <span>&nbsp;&nbsp;区块 ID：{{Leaderboard[0].blockhash}}</span>
        <br>
        <span>&nbsp;&nbsp;交易 ID：{{Leaderboard[0].transactionhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块 ID：{{Leaderboard[1].blockhash}}</span>
        <br>
        <span>&nbsp;&nbsp;交易 ID：{{Leaderboard[1].transactionhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块 ID：{{Leaderboard[2].blockhash}}</span>
        <br>
        <span>&nbsp;&nbsp;交易 ID：{{Leaderboard[2].transactionhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块 ID：{{Leaderboard[3].blockhash}}</span>
        <br>
        <span>&nbsp;&nbsp;交易 ID：{{Leaderboard[3].transactionhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;区块 ID：{{Leaderboard[4].blockhash}}</span>
        <br>
        <span>&nbsp;&nbsp;交易 ID：{{Leaderboard[4].transactionhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
      </div>

      <div>
        <span class="spanhistory">&nbsp;&nbsp;最新哈希<br></span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
        <span>&nbsp;&nbsp;图片哈希：{{Leaderboard[0].ipfshash}}</span>
        <br>
        <span>&nbsp;&nbsp;关联交易：{{Leaderboard[0].relationhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;图片哈希：{{Leaderboard[1].ipfshash}}</span>
        <br>
        <span>&nbsp;&nbsp;关联交易：{{Leaderboard[1].relationhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;图片哈希：{{Leaderboard[2].ipfshash}}</span>
        <br>
        <span>&nbsp;&nbsp;关联交易：{{Leaderboard[2].relationhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;图片哈希：{{Leaderboard[3].ipfshash}}</span>
        <br>
        <span>&nbsp;&nbsp;关联交易：{{Leaderboard[3].relationhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">

        <span>&nbsp;&nbsp;图片哈希：{{Leaderboard[4].ipfshash}}</span>
        <br>
        <span>&nbsp;&nbsp;关联交易：{{Leaderboard[4].relationhash}}</span>
        <hr size=2 style="color: #A9A9A9;border-style:dashed;margin:0 auto;width:94%">
      </div>
    </div>
  </div>
</template>

<script>
import Create from "@/js/create";
import Eva from "@/js/evaluate";

export default {
  data() {
    return {
      blocknumber:0,
      transactionnumber:0,
      accountnumber:0,
      ipfshashnumber:0,
      Leaderboard:{
        blockhigh:{},
      }
    }
  },
  created: async function() {
    try{
      var blockurl = 'http://localhost:6001/search/blocklist?key=all';
      var responseblockinfo = await fetch(blockurl);
      var blockinfo = await responseblockinfo.json();
      this.blocknumber = blockinfo.length;
      this.transactionnumber = blockinfo.length;

      var ownerurl = 'http://localhost:6001/search/blocklist/owner';
      var responseownerinfo = await fetch(ownerurl);      
      var ownerinfo = await responseownerinfo.json();
      this.accountnumber = ownerinfo.length;

      var ipfsurl = 'http://localhost:6001/search/Ipfshashlist';
      var responseipfsinfo = await fetch(ipfsurl);
      var ipfsinfo = await responseipfsinfo.json();
      this.ipfshashnumber = ipfsinfo.length;

      var blocklisturl = 'http://localhost:6001/search/blocklist?key=timestamp';
      var responseblocklistinfo = await fetch(blocklisturl);
      var blocklistinfo = await responseblocklistinfo.json();

      var ipfslisturl = 'http://localhost:6001/search/Ipfshashlist?key=timestamp';
      var responseipfslistinfo = await fetch(ipfslisturl);
      var ipfslistinfo = await responseipfslistinfo.json();

      var str;
      var result = "[";

      for(var i = 0;i<5;i++) {
        str =
          '{"blockhigh":"'          + blocklistinfo[i].blocknumber         +
          '","timestamp":"'         + blocklistinfo[i].timestamp           +
          '","blockhash":"'         + blocklistinfo[i].blockhash.slice(0,35)+'...'           +
          '","transactionhash":"'   + blocklistinfo[i].transactionid.slice(0,35)+'...'       +  
          '","ipfshash":"'          + ipfslistinfo[i].ipfshash.slice(0,30)+'...'             +  
          '","relationhash":"'      + ipfslistinfo[i].blockhash.slice(0,31)+'...'            +  
          '"}';

        result = result + str;
        if (i < 4) result = result + ",";
      }
      result = result + "]";

      result = JSON.parse(result);
      this.Leaderboard = result;
    }
    catch(err) {

    }
    
  },
  methods: {
    async checkblock() {
      this.$router.push({name: 'blocklist',params:{ id:'1'}});
    },
    async checktransaction() {
      this.$router.push({name: 'transactionlist',params:{ id:'1'}});
    },
    async checkaccount() {
      this.$router.push({name: 'accountlist',params:{ id:'1'}});
    },
    async checkipfs() {
      this.$router.push({name: 'ipfslist',params:{ id:'1'}});
    },
  }
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
    height: 300px;
    border: 1px solid gray;
  }
</style>
<!-- Add "scoped" attribute to limit CSS to this component only -->