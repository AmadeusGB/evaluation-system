<template>
  <div>
    <div>
      <el-button @click="createmission()" type="primary" round>新增评估任务</el-button>
      <el-button @click="updatedata()" type="primary" round>更新数据</el-button>
    </div>

    <el-table ref="singleTable" :data="tableData" highlight-current-row style="width: 100%">
      <el-table-column fixed label="序号" type="index" width="80"></el-table-column>

      <el-table-column prop="ordernumber" label="评估单编号" width="160"></el-table-column>
      <el-table-column prop="name" label="任务类型" width="100"></el-table-column>
      <el-table-column prop="createtime" label="创建时间" width="200"></el-table-column>
      <el-table-column prop="evaluationaddress" label="评估师地址" width="450"></el-table-column>
      <el-table-column prop="servicetoken" label="服务通证" width="150"></el-table-column>
      <el-table-column prop="timecost" label="评估实际耗时(s)" width="150"></el-table-column>
      <el-table-column prop="load" label="当前负载" width="120"></el-table-column>
      <el-table-column prop="state" label="评估状态" width="120"></el-table-column>

      <el-table-column fixed="right" label="操作" width="120">
        <template slot-scope='scope'>
          <el-button @click="detail(scope.row)" type="text" size="small">详情</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>


<script>
import Demo from "@/js/beyondsim";

export default {
  data() {
    return {
      tableData: [
        // {
        //   address: "2019092000001",
        //   name: "M1",
        //   vin: "2019-09-20 15:17:59",
        //   type:"0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0",
        //   state: "10",
        //   date: "60"
        // },
        // {
        //   address: "2019092000001",
        //   name: "M1",
        //   vin: "2019-09-20 15:17:59",
        //   type:"0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0",
        //   state: "10",
        //   date: "60"
        // }
      ]
    };
  },
  created: async function() {
    await Demo.init_user();
    
    var temp = await Demo.backrecordnumber();
    var result = "[";
    var num = temp.length;
    var str;
    var missionname;
    var stick = new Array();
    var evaluationstate;

    for (var i = 0; i < num; i++) {
      var tmp = await Demo.displaymodelinfo(temp[i], 2,0);
      if(tmp == 0) missionname = "M1";
      else if(tmp == 1) missionname = "M2";
      else if(tmp == 2) missionname = "M3";
      
      var tmp = await Demo.displaymodelinfo(temp[i], 6,0);
      if(tmp == 0) evaluationstate = "评估中";
      else evaluationstate = "评估任务完成";

      str =
        '{"ordernumber":"' + 
        (await Demo.displaymodelinfo(temp[i], 1,0))    +
        '","name":"'     +  missionname                +
        '","createtime":"'       +
        (await Demo.displaymodelinfo(temp[i], 3,0))    +
        '","evaluationaddress":"'    +
        (await Demo.displayaddressinfo(temp[i], 4,0)) +
        '","servicetoken":"'   + 
        (await Demo.displaymodelinfo(temp[i], 5,0))    +
        '","timecost":"'    +
        (await Demo.displaymodelinfo(temp[i], 6,0))    +
        '","load":"'   + 
        (await Demo.displaymodelinfo(temp[i], 7,0))    +
        '","state":"'     +  evaluationstate                +
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
    async createmission() {
      await Demo.robin();
    },
    async updatedata() {
      await Demo.check();
      this.$router.push({ name: "pagesim", params: { id: "3" } });
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
