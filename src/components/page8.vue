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
          <el-button @click="valuation(scope.row)" type="text" size="small">公诉</el-button>
          <el-button @click="detail(scope.row)" type="text" size="small">详情</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import Create from "@/js/create";
import Eva from "@/js/evaluate";

var tmp;

export default {
  created: async function() {
    await Create.init_user();
    await Eva.init_user();
    
    var temp = await Eva.backvalnumber();
    var num = temp.length;
    var result = "[";

    var str;
    var status;
    var stick = new Array();

    for (var i = 0; i < num; i++) {
      tmp = await Create.test1(temp[i], 9);
      var money = await Create.test1(temp[i], 7);
      if(tmp == "0") {
        status = "待评估";
        money = "暂无";
      }
      else if(tmp == "1") {
        status = "已评估";
        continue;
      }
      else if(tmp == "2") {
        status = "已申诉";
        continue;
      }
      else if(tmp == "3") {
        status = "申诉完成";
        continue;
      }
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
    //this.tableData = JSON.parse(result);
  },
  methods: {
    valuation(row) {
      this.$prompt("请输入评估价格(评估后价格不可修改)", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
      }).then(({ value }) => {
        Eva.evaluate(row.address,value);
        // this.$message({
        //   type: "success",
        //   message: "评估价格:" + value
        // });
      });
    },
    detail(row) {
      this.$router.push({name: 'detail',params:{ userid:row.address}});
    }
  },

  data() {
    return {
      activeIndex2: "1",
      tableData: [
        {
          address: "2019040200005",
          name: "宝马5系 2019款 540Li行政版",
          vin: "W2BCRAFZ3S9M687JE",
          money: "60万元",
          state: "已评估",
          date: "2018-12-20 11:56:48"
        },
        {
          address: "2019040200004",
          name: "丰田皇冠2005款 2.5L Royal",
          vin: "LFMBE85B680115110",
          money: "40万元",
          state: "已评估",
          date: "2018-12-20 11:57:52"
        },
        {
          address: "2019040200003",
          name: "奥迪A4L2015款 35 TFSI 自动标准型",
          vin: "LFV3A28K3E3400360",
          money: "50万元",
          state: "已评估",
          date: "2018-12-20 11:10:10"
        },
        {
          address: "2019040200002",
          name: "宝马7系2013款 730Li 领先型",
          vin: "WBAYE2106DDZ46100",
          money: "100万元",
          state: "已评估",
          date: "2018-12-20 10:50:32"
        },
        {
          address: "2019040200001",
          name: "宝马3系2014款 320Li 时尚型",
          vin: "LBV3M2100FMC96100",
          money: "30万元",
          state: "已评估",
          date: "2018-12-20 10:10:35"
        },
      ]
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->