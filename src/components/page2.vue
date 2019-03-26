<template>
  <div>
    <el-table
      ref="singleTable"
      :data="tableData"
      highlight-current-row
      @current-change="handleCurrentChange"
      style="width: 100%"
    >
      <el-table-column fixed label="序号" type="index" width="50"></el-table-column>

      <el-table-column prop="address" label="评估单编号" width="250"></el-table-column>
      <el-table-column prop="name" label="品牌型号" width="300"></el-table-column>
      <el-table-column prop="vin" label="车架号" width="180"></el-table-column>
      <el-table-column prop="money" label="评估金额" width="100"></el-table-column>
      <el-table-column prop="state" label="评估状态" width="100"></el-table-column>
      <el-table-column prop="date" label="提交时间" width="180"></el-table-column>

      <el-table-column fixed="right" label="操作" width="100">
        <template slot-scope="scope">
          <el-button @click="arbitration(scope.row)" type="text" size="small">申诉</el-button>
          <el-button @click="detail(scope.row)" type="text" size="small">详情</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import Create from "@/js/create";

export default {
  methods: {
    arbitration(row) {
      this.$prompt("请输入申诉原因", "提示", {
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
        await Create.appealdistribution(row.address,max[0],max[1],max[2],max[3],max[4]);
      });
    },
    detail(row) {
      this.$router.push({name: 'detail',params:{ userid:row.address}});
    },
    handleCurrentChange(val) {
      this.currentRow = val;
    }
  },
  created: async function() {
    await Create.init_user();
    
    var temp = await Create.backvaluation();
    var num = temp.length;
    var result = "[";

    var str;
    var status;
    var stick = new Array();

    for (var i = 0; i < num; i++) {
      var tmp = await Create.test1(temp[i], 9);
      var money = await Create.test1(temp[i], 7);
      console.log("tmp:" + tmp);
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
        '{"address":"' + temp[i]         +
        '","name":"'   +
        (await Create.test1(temp[i], 4)) +
        '","vin":"'    +
        (await Create.test1(temp[i], 1)) +
        '","money":"'  + money           +
        '","state":"'  + status          +
        '","date":"'   +
        (await Create.test1(temp[i], 8)) +
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
  data() {
    return {
      activeIndex2: "1",
      tableData: [
        // {
        //   address: "0x6f167c41920d42f16B984524f9b131b5D6a0AB5f",
        //   name: "宝马5系 2019款 540Li行政版",
        //   vin: "W2BCRAFZ3S9M687JE",
        //   money: "0",
        //   state: "待评估",
        //   date: "2018-12-20 11:28:48"
        // }
      ]
    };
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
