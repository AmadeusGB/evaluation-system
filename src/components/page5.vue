<template>
  <div>
    <el-table
      ref="singleTable"
      :data="tableData"
      highlight-current-row
      style="width: 100%"
    >
      <el-table-column fixed label="序号" type="index" width="80"></el-table-column>

      <el-table-column prop="address" label="评估单编号" width="350"></el-table-column>
      <el-table-column prop="name" label="品牌型号" width="280"></el-table-column>
      <el-table-column prop="vin" label="车架号" width="180"></el-table-column>
      <el-table-column prop="state" label="评估状态" width="120"></el-table-column>
      <el-table-column prop="date" label="提交时间" width="120"></el-table-column>

      <el-table-column fixed="right" label="操作" width="100">
        <template slot-scope="scope">
          <el-button v-if="situation" @click="valuation(scope.row)" type="text" size="small">仲裁</el-button>
          <el-button @click="detail(scope.row)" type="text" size="small">详情</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import Create from "@/js/create";
import Eva from "@/js/arbitrate";

var tmp;

export default {
  created: async function() {
    await Create.init_user();
    await Eva.init_user();
    
    var temp = await Eva.backappnumber();
    

    var num = temp.length;
    var result = "[";

    var str;
    var status;
    var stick = new Array();

    for (var i = 0; i < num; i++) {
      tmp = await Create.displayinfo(temp[i], 11);

      if(tmp == "0") {
        status = "待评估";
      }
      else if(tmp == "1") {
        status = "已评估";
        continue;
      }
      else if(tmp == "2") status = "申诉中";
      else if(tmp == "3") {
        status = "申诉完成";
        continue;
      }
      else if(tmp == "4") {
        status = "已关闭";
      }

      str =
        '{"address":"' + temp[i]         +
        '","name":"'   +
        (await Create.displayinfo(temp[i], 4)) +
        '","vin":"'    +
        (await Create.displayinfo(temp[i], 1)) +
        '","state":"'  + status          +
        '","date":"'   +
        (await Create.displayinfo(temp[i], 10)) +
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
    valuation(row) {
      this.$prompt("请输入仲裁价格（万元）", "操作", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
      }).then(async ({ value }) => {
        var address = row.address;
        var blockmsg = await Eva.appealevaluate(address,value);

        var flag = await Create.displayinfo(address, 11);
        var Evaluation_status = '仲裁中';
        if(flag == '3') {
          Evaluation_status = '仲裁完成';
        }

        var update_status_url = "http://localhost:6001/update/carinfo/Evaluation_status";
        var httpRequeststatusinfo = new XMLHttpRequest();
        var update_status_text = {
          'address':address,
          'Evaluation_status':Evaluation_status
        };
        httpRequeststatusinfo.open("POST", update_status_url, true);
        httpRequeststatusinfo.setRequestHeader("Content-type", "application/json");
        httpRequeststatusinfo.send(JSON.stringify(update_status_text));

        

        var blockurl = "http://localhost:6001/insert/blocklist";
        var mytime = new Date().toLocaleString('chinese', { hour12: false });
        var httpRequestblocklist = new XMLHttpRequest();
        var context = '更新评估单状态为：'+Evaluation_status;
        var blocktext = {
          'owner':window.web3.eth.accounts[0],
          'address':address,
          'gasused':blockmsg.receipt.gasUsed,
          'timestamp':mytime,
          'blockhash':blockmsg.receipt.blockHash,
          'blocknumber':blockmsg.receipt.blockNumber,
          'transactionid':blockmsg.receipt.transactionHash,
          'token':0,
          'location':'localhost:8080',
          'detail':context
          };
        httpRequestblocklist.open("POST", blockurl, true);
        httpRequestblocklist.setRequestHeader("Content-type", "application/json");
        httpRequestblocklist.send(JSON.stringify(blocktext));

      });
    },
    back(row) {
      
    },
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    },
    detail(row) {
      this.$router.push({name: 'detail',params:{ userid:row.address}});
    }
  },

  data() {
    return {
      activeIndex2: "1",
      situation: 1,
      tableData: [
        // {
        //   address: "0x6f167c41920d42f16B984524f9b131b5D6a0AB5f",
        //   name: "宝马5系 2019款 540Li行政版",
        //   vin: "W2BCRAFZ3S9M687JE",
        //   state: "提交仲裁",
        //   date: "2018-12-20 11:28:48"
        // }
      ]
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->