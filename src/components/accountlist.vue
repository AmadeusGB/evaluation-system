<template>
    <div>
        <span class="span-blockheader">&nbsp;&nbsp;账户列表</span>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;共106个账户被发现</span>
        <el-table ref="multipleTable" :data="tableData" border style="width: 100%" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="60"></el-table-column>
            <el-table-column prop="eNumber" label="账户地址" width="400" sortable></el-table-column>
            <el-table-column prop="eName" label="首次活动时间" show-overflow-tooltip></el-table-column>
            <el-table-column prop="eIndustry" label="区块数量" width="200"></el-table-column>
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
                tableData: [{
                    eNumber: '0xFFcf8FDEE72ac11b5c542428B35EEF5769C409f0',
                    eName: '2019-03-27 09:04:19',
                    eIndustry: '5'
                },
                {
                    eNumber: '0x22d491Bde2303f2f43325b2108D26f1eAbA1e32b',
                    eName: '2019-03-27 09:04:13',
                    eIndustry: '3'
                },
                {
                    eNumber: '0xE11BA2b4D45Eaed5996Cd0823791E0C93114882d',
                    eName: '2019-03-27 00:31:28',
                    eIndustry: '7'
                }],
                multipleSelection: []
            }
        },
        created: function(){
            // 组件创建完后获取数据，
            // 此时 data 已经被 observed 了
            this.fetchData();
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