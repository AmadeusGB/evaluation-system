<template>
  <div>
    <el-table
      ref="singleTable"
      :data="tableData"
      highlight-current-row
      style="width: 100%"
    >
      <el-table-column fixed label="最新工单" type="index" width="100"></el-table-column>

      <el-table-column prop="address" label="评估单编号" width="220"></el-table-column>
      <el-table-column prop="name" label="品牌型号" width="300"></el-table-column>
      <el-table-column prop="vin" label="车架号" width="180"></el-table-column>
      <el-table-column prop="money" label="评估金额" width="100"></el-table-column>
      <el-table-column prop="state" label="评估状态" width="90"></el-table-column>
      <el-table-column prop="date" label="提交时间" width="170"></el-table-column>

      <el-table-column fixed="right" label="操作" width="140">
        <template slot-scope="scope">
          <el-button @click="arbitration(scope.row)" type="text" size="small">公诉</el-button>
          <el-button @click="detail(scope.row)" type="text" size="small">详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination background
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[10, 50, 100, 200]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total">
    </el-pagination>

  </div>
</template>

<script>
import Create from "@/js/create";
import Board from "@/js/leaderboard";

var tmp;

export default {
  created: async function() {
    await Create.init_user();
    await Board.init_user();
    
    var temp = await Board.backLeaderboard();
    var num = await Board.backLength();
    num = num.c[0]-1;

    var result = "[";

    var str;
    var status;
    var stick = new Array();

    for (var i = num; i >= 0; i--) {

      if(temp[i].c[0] == 0) break;
      var tmp = await Create.displayinfo(temp[i].c[0], 11);
      var money = await Create.displayvalue(temp[i].c[0]) + "万元";
      
      if(tmp == "0") {
        status = "待评估";
        money = "暂无";
        continue;
      }
      else if(tmp == "1") status = "已评估";
      else if(tmp == "2") status = "已申诉";
      else if(tmp == "3") status = "申诉完成";
      else if(tmp == "4") {
        status = "已关闭";
        money = "暂无";
      }

      str =
        '{"address":"' + temp[i].c[0]         +
        '","name":"'   +
        (await Create.displayinfo(temp[i].c[0], 4)) +
        '","vin":"'    +
        (await Create.displayinfo(temp[i].c[0], 1)) +
        '","money":"'  + money           +
        '","state":"'  + status          +
        '","date":"'   +
        (await Create.displayinfo(temp[i].c[0], 10)) +
        '"}';

      stick.push(str);
    }

    num = stick.length;
    for(var i = 0;i < num;i++) {
      result = result + stick[i];
      if(i < num-1) result = result + ",";
    }
    result = result + "]";
    this.tableData = JSON.parse(result);
  },
  methods: {
    arbitration(row) {
      this.$prompt("请输入公诉原因", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
      }).then(async ({ value }) => {
        //本函数内的代码，为了实现选出所有评估师的前5名
        var map = {};
        var max = ["0","0","0","0","0"];
        var assessor = await Create.backofwork();
        
        for(var i = 0;i < assessor.length;i++) {
          var tmp = await Create.displayaccountforarbitrage(assessor[i]);
        
          if(tmp > await Create.displayaccountforarbitrage(max[0])) {
            max[4] = max[3];
            max[3] = max[2];
            max[2] = max[1];
            max[1] = max[0];
            max[0] = assessor[i];
          }
          else if(tmp > await Create.displayaccountforarbitrage(max[1])) {
            max[4] = max[3];
            max[3] = max[2];
            max[2] = max[1];
            max[1] = assessor[i];
          }
          else if(tmp > await Create.displayaccountforarbitrage(max[2])) {
            max[4] = max[3];
            max[3] = max[2];
            max[2] = assessor[i];
          }
          else if(tmp > await Create.displayaccountforarbitrage(max[3])) {
            max[4] = max[3];
            max[3] = assessor[i];
          }
          else if(tmp > await Create.displayaccountforarbitrage(max[4])) {
            max[4] = assessor[i];
          }
        }      

        var address = row.address;
        var Evaluation_status = "已公诉";
        var update_status_url =
          "http://localhost:6001/update/carinfo/Evaluation_status";
        var httpRequeststatusinfo = new XMLHttpRequest();
        var update_status_text = {
          address: address,
          Evaluation_status: Evaluation_status
        };
        httpRequeststatusinfo.open("POST", update_status_url, true);
        httpRequeststatusinfo.setRequestHeader(
          "Content-type",
          "application/json"
        );
        httpRequeststatusinfo.send(JSON.stringify(update_status_text));

        var blockmsg = await Create.appealdistribution(row.address,max[0],max[1],max[2],max[3],max[4]);

        var blockurl = "http://localhost:6001/insert/blocklist";
        var mytime = new Date().toLocaleString('chinese', { hour12: false });
        var httpRequestblocklist = new XMLHttpRequest();
        var context = "更新评估单状态：" + Evaluation_status;
        var blocktext = {
          owner: window.web3.eth.accounts[0],
          address: address,
          gasused: blockmsg.receipt.gasUsed,
          timestamp: mytime,
          blockhash: blockmsg.receipt.blockHash,
          blocknumber: blockmsg.receipt.blockNumber,
          transactionid: blockmsg.receipt.transactionHash,
          token: 0,
          location: "localhost:8080",
          detail: context
        };
        httpRequestblocklist.open("POST", blockurl, true);
        httpRequestblocklist.setRequestHeader(
          "Content-type",
          "application/json"
        );
        httpRequestblocklist.send(JSON.stringify(blocktext));
      });
    },
    detail(row) {
      this.$router.push({name: 'detail',params:{ userid:row.address}});
    },
    callbackFunction(result) {
        alert(result + "aaa");
    },
    fetchData(){ //获取数据
      this.$http.jsonp("http://localhost:8080/wproject/view/enterprise!getListByParam.action",{//跨域请求数据
        params: {
            keywords:this.keyword//输入的关键词
        },
        jsonpCallback:'callbackFunction'//这里是callback
      }).then(function(res) {//请求成功回调，请求来的数据赋给searchList数组
        this.total = res.body.count;
        this.currentPage = res.body.curr;
        this.tableData = res.body.data;
        console.info(res);
      },function(res) {//失败显示状态码
        alert("res.status:"+res.status)
      })
    },

    handleSizeChange(val){
      this.pageSize = val;
      this.currentPage = 1;
      this.fetchData(1, val);
      // console.log(`每页 ${val} 条`);
    },
    handleCurrentChange(val){
      this.currentPage = val;
      this.fetchData(val, this.pageSize);
      // console.log(`当前页: ${val}`);
    }
  },

  data() {
    return {
      activeIndex2: "1",
      total: 5,
      currentPage: 1,
　　　 pageSize: 10,
      tableData: [
        // {
        //   address: "2019040200005",
        //   name: "宝马5系 2019款 540Li行政版",
        //   vin: "W2BCRAFZ3S9M687JE",
        //   money: "60万元",
        //   state: "已评估",
        //   date: "2018-12-20 11:56:48"
        // },
        // {
        //   address: "2019040200004",
        //   name: "丰田皇冠2005款 2.5L Royal",
        //   vin: "LFMBE85B680115110",
        //   money: "40万元",
        //   state: "已评估",
        //   date: "2018-12-20 11:57:52"
        // },
        // {
        //   address: "2019040200003",
        //   name: "奥迪A4L2015款 35 TFSI 自动标准型",
        //   vin: "LFV3A28K3E3400360",
        //   money: "50万元",
        //   state: "已评估",
        //   date: "2018-12-20 11:10:10"
        // },
        // {
        //   address: "2019040200002",
        //   name: "宝马7系2013款 730Li 领先型",
        //   vin: "WBAYE2106DDZ46100",
        //   money: "100万元",
        //   state: "已评估",
        //   date: "2018-12-20 10:50:32"
        // },
        // {
        //   address: "2019040200001",
        //   name: "宝马3系2014款 320Li 时尚型",
        //   vin: "LBV3M2100FMC96100",
        //   money: "30万元",
        //   state: "已评估",
        //   date: "2018-12-20 10:10:35"
        // },
      ]
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->