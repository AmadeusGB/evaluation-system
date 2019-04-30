<template>
  <div class="imgBox">
    <p>{{message}} </p>
    <div style="width:148px" v-for="(item,i) in ary" :key="i">
      <p style="text-align:center">{{item}}</p>
      <el-upload
        action="https://jsonplaceholder.typicode.com/posts/"
        list-type="picture-card"
        :show-file-list="false"
        :on-preview="handlePictureCardPreview"
        :before-upload="handleUpload"
        :limit="1"
      >
      <img v-if="testdemo[i]" :src="testdemo[i]" class="avatar" width="148" height="148">
      <i v-else class="el-icon-plus avatar-uploader-icon"></i>
      </el-upload>
      <el-dialog :visible.sync="dialogVisible">
        <img width="100%" :src="dialogImageUrl" alt>
      </el-dialog>
    </div>
    <div v-if="testdemo[7]">
      <el-button @click="createvaluation()" type="primary" round>新增评估单</el-button>
    </div>
  </div>
</template>


<script>
import Demo from "@/js/create";

const ipfsAPI = require("ipfs-api");


export default {
  data() {
    return {
      ary: [
        "合格证",
        "左前45度",
        "左前门",
        "左后门",
        "右前门",
        "右后45度",
        "中控台",
        "车内顶"
      ],
      dialogImageUrl: "",
      imgurl: [],
      testdemo: [],
      dialogVisible: false,
      message: "第二步:"
    };
  },
  created: function() {
    Demo.init_user();
  },
  methods: {
    async createvaluation() {
      var valuation_number = this.$route.params.userid;;

      var photourl = "http://localhost:6001/insert/photoinfo";
      var mytime=new Date().toLocaleString();
      var httpRequestphoto = new XMLHttpRequest();
      var phototext = {
        'address':valuation_number,
        'photo1':this.imgurl[0],
        'photo2':this.imgurl[1],
        'photo3':this.imgurl[2],
        'photo4':this.imgurl[3],
        'photo5':this.imgurl[4],
        'photo6':this.imgurl[5],
        'photo7':this.imgurl[6],
        'photo8':this.imgurl[7]
        };
      httpRequestphoto.open("POST", photourl, true);
      httpRequestphoto.setRequestHeader("Content-type", "application/json");
      httpRequestphoto.send(JSON.stringify(phototext));


      var ipfsmsg = await Demo.addphoto(
        this.testdemo[0],
        this.testdemo[1],
        this.testdemo[2],
        this.testdemo[3],
        this.testdemo[4],
        this.testdemo[5],
        this.testdemo[6],
        this.testdemo[7],
        valuation_number
      );

      var blocklisturl = "http://localhost:6001/insert/blocklist";
      var mytime= new Date().toLocaleString('chinese', { hour12: false });
      var httpRequestblocklist = new XMLHttpRequest();
      var context = '添加评估单图片';
      var blocklisttext = {
        'address':valuation_number,
        'gasused':ipfsmsg.receipt.gasUsed,
        'timestamp':mytime,
        'blockhash':ipfsmsg.receipt.blockHash,
        'blocknumber':ipfsmsg.receipt.blockNumber,
        'transactionid':ipfsmsg.receipt.transactionHash,
        'token':0,
        'location':'localhost:8080',
        'detail':context
        };
      httpRequestblocklist.open("POST", blocklisturl, true);
      httpRequestblocklist.setRequestHeader("Content-type", "application/json");
      httpRequestblocklist.send(JSON.stringify(blocklisttext));


      for(var i = 0;i < 8;i++) {
        var ipfslisturl = "http://localhost:6001/insert/Ipfshashlist";
        var httpRequestipfslist = new XMLHttpRequest();
        var ipfslisttext = {
          'blocknumber':ipfsmsg.receipt.blockNumber,
          'ipfshash':this.imgurl[i],
          'blockhash':ipfsmsg.receipt.blockHash,          
          'location':'localhost:5000'
          };
        httpRequestipfslist.open("POST", ipfslisturl, true);
        httpRequestipfslist.setRequestHeader("Content-type", "application/json");
        httpRequestipfslist.send(JSON.stringify(ipfslisttext));
      }

      this.$router.push({ name: "page1", params: { id: "3" } });
    },

    async upload2ipfs(render) {
      let that = this;
      // connect to ipfs daemon API server
      var ipfs = ipfsAPI({ protocol: "http", host: "localhost", port: 5001 });
      let buffer = Buffer.from(render.result);
      var response = await ipfs.add(buffer);
      this.imgurl.push(response[0].hash);
      this.testdemo.push("http://localhost:5000/ipfs/" + response[0].hash);
    },
    handleUpload(file) {
      let that = this;
      let filename = window.URL.createObjectURL(file);
      let render = new FileReader();

      render.readAsArrayBuffer(file);
      render.onload = function() {
        that.upload2ipfs(render);
      };
    },
    handlePictureCardPreview(file) {
    }
  }
};
</script>

<style>
.imgBox {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  flex-wrap: wrap;
}
</style>
