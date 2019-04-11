<template>
  <div>
    <p>第一步: <br> </p>
    <el-form ref="form" :model="form" label-width="100px" size="medium">
      <el-form-item style="width:400px;" label="车架号">
        <el-input v-model="form.Frame"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="品牌型号">
        <el-input v-model="form.Brand"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="号码车牌">
        <el-input v-model="form.Number"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="汽车排量(L)">
        <el-input v-model="form.displacement"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="核定载客量">
        <el-input v-model="form.passengers"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="发动机编号">
        <el-input v-model="form.Engine"></el-input>
      </el-form-item>

      <el-form-item style="width:400px;" label="车辆类型">
        <el-select v-model="form.Vehicle" placeholder="请选择使用性质">
          <el-option label="营运" value="营运"></el-option>
          <el-option label="非营运" value="非营运"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item style="width:535px;" label="出厂日期">
        <el-col :span="11">
          <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>
        </el-col>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="onSubmit">下一步</el-button>
        <el-button @click="onCancel">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import Demo from "@/js/create";

export default {
  data() {
    return {
      activeIndex2: "1",
      form: {
        Brand: "",
        Number: "",
        Frame: "",
        Engine: "",
        Vehicle: "",
        date1: "",
        displacement:"",
        passengers:""
      }
    };
  },
  created: async function() {
    await Demo.init_user();
  },
  methods: {
    async onCancel() {
      this.$router.push({ name: "page1", params: { id: "2" } });
    },
    async onSubmit() {
      try {
          await Demo.addvaluation(
          this.form.Frame.toString(),
          this.form.Number.toString(),
          this.form.Vehicle.toString(),
          this.form.Brand.toString(),          
          this.form.displacement.toString(),
          this.form.passengers.toString(),
          this.form.Engine.toString(),
          this.form.date1.toLocaleDateString(),
          new Date().toLocaleString(),
          await Demo.backordernumber()
        );

        this.$router.push({ name: "create2", params: { id: "3" } });
      }
      catch(err) {
        alert("请填写完成本页面信息后,点击下一步");
        console.log(err);
      }
      
    }
  }
};
</script>

