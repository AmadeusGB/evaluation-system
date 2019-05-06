<template>
  <div>
    <el-table style="width: 100%;" :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)">
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
        :total="tableData.length">
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

    // 初始页currentPage、初始每页数据数pagesize和数据data
    handleSizeChange: function (size) {
            this.pagesize = size;
    },
    handleCurrentChange: function(currentPage){
            this.currentPage = currentPage;
    }
    
  },

  data() {
    return {
      currentPage: 1,
      pageSize: 10,
      tableData: []
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->