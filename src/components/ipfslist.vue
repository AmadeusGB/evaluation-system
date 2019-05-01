<template>
    <div>
        <span class="span-blockheader">&nbsp;&nbsp;IPFS哈希列表</span>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;共{{msgtotal}}个哈希被发现</span>
        <el-table ref="multipleTable" :data="tableData" border style="width: 100%" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="60"></el-table-column>
            <el-table-column prop="blocknumber" label="区块号" width="120" sortable></el-table-column>
            <el-table-column prop="ipfshash" label="哈希值" width="430"></el-table-column>
            <el-table-column prop="blockhash" label="区块ID" show-overflow-tooltip></el-table-column>
            <el-table-column prop="location" label="所属侧链" width="180"></el-table-column>
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
    export default {
        data() {
            return {
                keyword: "集团",
                total: 5,
                currentPage: 1,
　　　　　　　　　 pageSize: 10,
                msgtotal:0,
                tableData: [],
                multipleSelection: []
            }
        },
        created: async function(){
            // 组件创建完后获取数据，
            // 此时 data 已经被 observed 了
            this.fetchData();

            var ipfsurl = 'http://localhost:6001/search/Ipfshashlist';
            var responseipfsinfo = await fetch(ipfsurl);
            var ipfsinfo = await responseipfsinfo.json();

            var str;
            var num = ipfsinfo.length;
            var result = "[";

            for(var i = 0;i<num;i++) {
                str =
                '{"blocknumber":"' + ipfsinfo[i].blocknumber         +
                '","ipfshash":"'   + ipfsinfo[i].ipfshash            +
                '","blockhash":"'  + ipfsinfo[i].blockhash           +
                '","location":"'   + ipfsinfo[i].location            +
                '"}';

                result = result + str;
                if (i < num - 1) result = result + ",";
            }
            result = result + "]";

            this.msgtotal = num;

            this.tableData = JSON.parse(result);
        },
        methods: {
            toggleSelection(rows) {
                if (rows) {
                    rows.forEach(function(row)  {
                        this.$refs.multipleTable.toggleRowSelection(row);
                    });
                } else {
                    this.$refs.multipleTable.clearSelection();
                }
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            callbackFunction(result) {
                alert(result + "aaa");
            },
            fetchData(){ //获取数据
            //   this.$http.jsonp("http://localhost:8080/wproject/view/enterprise!getListByParam.action",{//跨域请求数据
            //     params: {
            //         keywords:this.keyword//输入的关键词
            //     },
            //     jsonpCallback:'callbackFunction'//这里是callback
            //   }).then(function(res) {//请求成功回调，请求来的数据赋给searchList数组
            //     this.total = res.body.count;
            //     this.currentPage = res.body.curr;
            //     this.tableData = res.body.data;
            //     console.info(res);
            //   },function(res) {//失败显示状态码
            //     alert("res.status:"+res.status)
            //   })
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
 
    }
}
</script>
<style>
    .span-blockheader{
        font-size: 20px;
        font-weight: 500;
        line-height: 30px;
    }
    .el-table th {
        text-align: left;
    }

    .el-table tbody tr td:first-child {
        text-align: left;
    }
</style>