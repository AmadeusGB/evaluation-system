<template>
    <div>
        <span class="span-blockheader">&nbsp;&nbsp;账户列表</span>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;共{{tableData.length}}个账户被发现</span>
        <el-table style="width: 100%;" :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)">
            <el-table-column type="selection" width="60"></el-table-column>
            <el-table-column prop="account" label="账户地址" width="400" sortable></el-table-column>
            <el-table-column prop="firsttime" label="首次活动时间" show-overflow-tooltip></el-table-column>
            <el-table-column prop="blockcount" label="区块数量" width="200"></el-table-column>
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
            var ownerurl = 'http://localhost:6001/search/blocklist/owner';
            var responseownerinfo = await fetch(ownerurl);      
            var ownerinfo = await responseownerinfo.json();

            var str;
            var num = ownerinfo.length;
            var result = "[";

            for(var i = 0;i<num;i++) {
                var blockurl = 'http://localhost:6001/search/blocklist?key=owner&param=' + ownerinfo[i].owner;
                var responseblockinfo = await fetch(blockurl);      
                var blockinfo = await responseblockinfo.json();

                str =
                '{"account":"'      + ownerinfo[i].owner             +
                '","firsttime":"'   + blockinfo[0].timestamp         +
                '","blockcount":"'  + blockinfo.length               +  
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