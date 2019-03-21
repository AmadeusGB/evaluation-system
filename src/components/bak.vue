<template>
  <div class="container">
    <el-upload
      class="upload-demo"
      action
      ref="upload"
      :auto-upload="true"
      :before-upload="onBefore"
      accept="image/jpeg, image/gif, image/png, image/bmp"
      multiple
    ></el-upload>

    <p>车架号</p>
    <el-upload action list-type="picture-card" :before-upload="beforeAvatarUpload">
      <i class="el-icon-plus"></i>
    </el-upload>

    <el-form-item label="上传附件：" class="form_lable_small">
      <uploadMy :disabled="isEditor" text="上传拍照框架图" v-model="bgPhotoId"></uploadMy>
      <uploadMy :disabled="isEditor" text="上传拍照说明图" v-model="descPhotoId"></uploadMy>
      <div class="imageDes">单击放大图片，双击修改图片。</div> 
    </el-form-item>

    <el-dialog :visible.sync="dialogVisible">
      <img width="100%" :src="dialogImageUrl" alt>
    </el-dialog>
  </div>
</template>

<script>
var reader;
import ipfsAPI from "ipfs-api";
const ipfsApiAddress = {
  protocol: "http",
  host: "localhost",
  port: 5001
};
const ipfsGatewayUrl = "http://localhost:5000";

const ipfs = ipfsAPI(ipfsApiAddress);

export default {
  data() {
    return {
      dialogImageUrl: "",
      dialogVisible: false
    };
  },
  methods: {
    async UploadUrl() {
      const buffer = Buffer.from(reader.result);
      rsp = await ipfs.add(buffer);
      console.log("rsp: " + rsp);
    },
    beforeAvatarUpload() {
      const file = event.target.files[0];
      console.log("file: " + file);
      reader = new window.FileReader();
      reader.readAsArrayBuffer(file);
      console.log("reader: " + reader);
    },
    bgPhotoId() {

    },
    descPhotoId() {

    }
  }
};
</script>