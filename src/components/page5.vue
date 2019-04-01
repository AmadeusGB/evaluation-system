<template>
  <div>
    <el-table
      ref="singleTable"
      :data="tableData"
      highlight-current-row
      style="width: 100%"
    >
      <el-table-column fixed label="序号" type="index" width="50"></el-table-column>

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
      tmp = await Create.test1(temp[i], 9);

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
        (await Create.test1(temp[i], 4)) +
        '","vin":"'    +
        (await Create.test1(temp[i], 1)) +
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
  methods: {
    valuation(row) {
      this.$prompt("请输入仲裁价格", "操作", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
      }).then(async ({ value }) => {
        await Eva.appealevaluate(row.address,value);
        // this.$message({
        //   type: "success",
        //   message: "仲裁价格:" + value + "元"
        // });
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