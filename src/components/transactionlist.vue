<template>
    <div>
        <span class="span-blockheader">&nbsp;&nbsp;交易列表</span>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;共{{tableData.length}}个交易被发现</span>
        <el-table style="width: 100%;" :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)">
            <el-table-column type="selection" width="40"></el-table-column>
            <el-table-column prop="blockhash" label="区块ID" width="480" sortable></el-table-column>
            <el-table-column prop="transactionid" label="交易ID" width="480" sortable></el-table-column>
            <el-table-column prop="timestamp" label="创建时间戳（UTC)" width="165"></el-table-column>
            <el-table-column prop="location" label="所属侧链" width="120"></el-table-column>
        </el-table>
        <el-pagination background
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="[10, 50, 100, 200]"
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="tableData.length">
        </el-pagination>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                currentPage: 1,
                pageSize: 10,
                tableData: []
            }
        },
        created: async function(){
            var blockurl = 'http://localhost:6001/search/blocklist?key=all';
            var responseblockinfo = await fetch(blockurl);
            var blockinfo = await responseblockinfo.json();

            this.blocktransaction = blockinfo.length;

            var str;
            var num = blockinfo.length;
            var result = "[";

            for(var i = 0;i<num;i++) {
                str =
                '{"blockhash":"' + blockinfo[i].blockhash         +
                '","transactionid":"'  + blockinfo[i].transactionid           +
                '","timestamp":"'  + blockinfo[i].timestamp           +
                '","location":"'   + blockinfo[i].location            +   
                '"}';

                result = result + str;
                if (i < num - 1) result = result + ",";
            }
            result = result + "]";

            this.tableData = JSON.parse(result);
        },
        methods: {
           // 初始页currentPage、初始每页数据数pagesize和数据data
            handleSizeChange: function (size) {
                    this.pagesize = size;
            },
            handleCurrentChange: function(currentPage){
                    this.currentPage = currentPage;
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