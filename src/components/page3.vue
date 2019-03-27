<template>
  <div>
    <el-table ref="singleTable" :data="tableData" highlight-current-row style="width: 100%">
      <el-table-column prop="address" label="用户地址" width="350"></el-table-column>
      <el-table-column prop="balance" label="账户余额" width="200"></el-table-column>
      <el-table-column prop="token" label="持有通证" width="125"></el-table-column>
      <el-table-column prop="tokenprice" label="通证价格" width="125"></el-table-column>
      <el-table-column prop="transaction" label="操作次数" width="100"></el-table-column>
      <el-table-column prop="worth" label="总价值" width="140"></el-table-column>

      <el-table-column fixed="right" label="操作" width="250">
        <template slot-scope="scope">
          <el-button @click="buytoken(scope.row)" type="text" size="small">购买通证</el-button>
          <el-button @click="selltoken(scope.row)" type="text" size="small">卖出通证</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import token from "@/js/token";

export default {
  data() {
    return {
      tableData: []
    };
  },
  created: async function() {
    await token.init_token();
    var balance = await token.displaybalance();
    var account = await token.displayaccount();
    var CirculationToken = await token.displaytoken();
    if (balance == 0) balance = 0.1;
    var price = balance / (CirculationToken * 0.5);
    var Eth_amount = (1 - Math.pow(1 - account / CirculationToken, 2)) * balance;
    Eth_amount = Math.abs(Eth_amount);

    var result =
      '[{"address":"' +
      (await window.web3.eth.accounts[0]) +
      '","balance":"' +
      (await token.displayethbalance()) +
      '","token":"' +
      (account) +
      '","tokenprice":"' +
      price.toFixed(2) +
      '","worth":"' +
      Eth_amount.toFixed(0) +
      '","transaction":"' +
      (await token.distranumber()) +
      '"}]';
    this.tableData = JSON.parse(result);
  },
  methods: {
    buytoken(row) {
      this.$prompt("请输入购买通证数量", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消"
      }).then(async ({ value }) => {
        var balance = await token.displaybalance();
        var supply = await token.displaytoken();
        if (balance == 0) balance = 1;
        var Eth_amount = (Math.pow(value / supply + 1, 2) - 1) * balance;
        Eth_amount = Math.round(Eth_amount);

        console.log(Eth_amount);

        await token.buy(value, Eth_amount);
        parent.location.reload();
      });
    },
    selltoken(row) {
      this.$prompt("请输入卖出通证数量", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消"
      }).then(async ({ value }) => {
        var balance = await token.displaybalance();
        var supply = await token.displaytoken();
        if (balance == 0) balance = 1;
        var Eth_amount = (1 - Math.pow(1 - value / supply, 2)) * balance;
        Eth_amount = Math.round(Eth_amount);

        console.log(Eth_amount);
        
        await token.sell(value, Eth_amount);
        parent.location.reload();
      });
    }
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
