<template>
  <div>
    <div>
      <el-button @click="createvaluation()" type="primary" round>新增评估单</el-button>
    </div>

    <el-table ref="singleTable" :data="tableData" highlight-current-row style="width: 100%">
      <el-table-column fixed label="序号" type="index" width="80"></el-table-column>

      <el-table-column prop="address" label="评估单编号" width="250"></el-table-column>
      <el-table-column prop="name" label="品牌型号" width="250"></el-table-column>
      <el-table-column prop="vin" label="车架号" width="200"></el-table-column>
      <el-table-column prop="type" label="车辆类型" width="120"></el-table-column>
      <el-table-column prop="state" label="评估状态" width="120"></el-table-column>
      <el-table-column prop="date" label="提交时间" width="180"></el-table-column>

      <el-table-column fixed="right" label="操作" width="100">
        <template slot-scope='scope'>
          <el-button @click="detail(scope.row)" type="text" size="small">详情</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>


<script>
import Demo from "@/js/create";

export default {
  data() {
    return {
      tableData: [
        // {
        //   address: "0x6f167c41920d42f16B984524f9b131b5D6a0AB5f",
        //   name: "宝马5系 2019款 540Li行政版",
        //   vin: "W2BCRAFZ3S9M687JE",
        //   state: "待评估",
        //   date: "2018-12-20 11:28:48"
        // }
      ]
    };
  },
  created: async function() {
    await Demo.init_user();
    
    var temp = await Demo.backvaluation();
    var result = "[";
    var num = temp.length;
    var str;
    var status;
    var stick = new Array();

    for (var i = 0; i < num; i++) {
      var tmp = await Demo.displayinfo(temp[i], 11);
      if(tmp == "0") status = "待评估";
      else continue;
      // else if(tmp == "2") status = "已申诉";
      // else if(tmp == "3") status = "申诉完成";

      str =
        '{"address":"' + temp[i]         +
        '","name":"'   +
        (await Demo.displayinfo(temp[i], 4)) +
        '","vin":"'    +
        (await Demo.displayinfo(temp[i], 1)) +
        '","type":"'    +
        (await Demo.displayinfo(temp[i], 3)) +
        '","state":"'  + status          +
        '","date":"'   +
        (await Demo.displayinfo(temp[i], 10)) +
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
    async createvaluation() {
      this.$router.push({name: 'create1',params:{ id:'1'}});
    },
    async detail(row) {
      //console.log(row.address);
      this.$router.push({name: 'detail',params:{ userid:row.address}});
    }
  }
};
</script>

<style lang="scss" scoped>
#signup {
  text-align: left;

  .form {
    display: flex;
    flex-direction: column;
    margin: auto;

    .entry {
      display: flex;
      flex-direction: row-reverse;
      justify-content: left;

      label {
        margin-right: 20px;
      }

      button {
        margin-left: 20px;
      }
    }
  }
}
</style>
