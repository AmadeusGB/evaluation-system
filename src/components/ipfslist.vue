<template>
    <div>
        <span class="span-blockheader">&nbsp;&nbsp;IPFS哈希列表</span>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;共10006个哈希被发现</span>
        <el-table ref="multipleTable" :data="tableData" border style="width: 100%" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="60"></el-table-column>
            <el-table-column prop="eNumber" label="区块号" width="120" sortable></el-table-column>
            <el-table-column prop="eIndustry" label="哈希值" width="430"></el-table-column>
            <el-table-column prop="eName" label="区块ID" show-overflow-tooltip></el-table-column>
            <el-table-column prop="eRange" label="所属侧链" width="180"></el-table-column>
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
                    eNumber: '10008',
                    eName: 'd5b6bbd40f76e50df264e0c22a85b8b057924366fac137169a700b6a0754cf45',
                    eIndustry: 'QmdPLwgsAtmm8sqcYKHdpKMMRN3pToMs2Ga28GdKTTYx8t',
                    eRange: 'localhost:8080'
                },
                {
                    eNumber: '10007',
                    eName: '18ed846d453bdaa5562816e7f44fe91eadbc3010eefa6e1b69fa8fa4a452a067',
                    eIndustry: 'QmdPLwgsAtmm8sqcYKHdpKMMRN3pToMs2Ga28GdKTTYx8q',
                    eRange: 'localhost:8080'
                },
                {
                    eNumber: '10006',
                    eName: '9b87b2564a8706c34105a6f84d97a77cd1a2c5336bbf51e1a3c1eda934e293e8',
                    eIndustry: 'QmdPLwgsAtmm8sqcYKHdpKMMRN3pToMs2Ga28GdKTTYx8a',
                    eRange: 'localhost:8080'
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