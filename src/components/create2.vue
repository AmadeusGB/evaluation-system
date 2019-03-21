<template>
  <div class="imgBox">
    <p>{{message}}</p>
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
    <div v-if="1">
      <el-button @click="createvaluation()" type="primary" round>新增评估单</el-button>
      <el-button @click="display()" type="primary" round>查看</el-button>
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
      imgurl: "",
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
      await Demo.addphoto(
        this.testdemo[0],
        this.testdemo[1],
        this.testdemo[2],
        this.testdemo[3],
        this.testdemo[4],
        this.testdemo[5],
        this.testdemo[6],
        this.testdemo[7]
      );
      this.$router.push({ name: "page1", params: { id: "3" } });
    },

    async display() {
    },
    async upload2ipfs(render) {
      let that = this;
      // connect to ipfs daemon API server
      var ipfs = ipfsAPI({ protocol: "http", host: "localhost", port: 5001 });
      let buffer = Buffer.from(render.result);
      var response = await ipfs.add(buffer);
      this.testdemo.push("http://localhost:5000/ipfs/" + response[0].hash);
      console.log(this.testdemo);
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
      console.log(file);
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
