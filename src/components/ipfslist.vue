<template>
    <div>
        <span class="span-blockheader">&nbsp;&nbsp;IPFS哈希列表</span>
        <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;共{{tableData.length}}个哈希被发现</span>
        <el-table style="width: 100%;" :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)">
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