<template>

  <el-descriptions title="员工个人信息" direction="vertical" column=2 size=large border>
    <el-descriptions-item label="姓名" :span="2">
      {{ user[0].name }}
    </el-descriptions-item>
    <el-descriptions-item label="性别">
      {{ user[0].sex }}
    </el-descriptions-item>
    <el-descriptions-item label="员工号">
      {{ this.id }}
    </el-descriptions-item>
    <el-descriptions-item label="电话">
      {{ user[0].phone }}
    </el-descriptions-item>
    <el-descriptions-item label="邮箱">
      {{ user[0].email }}
    </el-descriptions-item>
    <el-descriptions-item label="职级">
      <el-tag size="large">{{ user[0].grade }}</el-tag>
    </el-descriptions-item>
    <el-descriptions-item label="入职时间">
      {{ user[0].hiredate }}
    </el-descriptions-item>
  </el-descriptions>

  <br>
  <el-button @click="centerDialogVisible = true" type="info" plain style="float: right;">修改信息</el-button>

  <el-dialog v-model="centerDialogVisible" title="修改信息" width="500" center>

    <el-form :model="form" label-width="auto" style="max-width: 600px">
      <el-form-item label="姓名">
        <el-input v-model="user[0].name" />
      </el-form-item>
      <el-form-item label="性别">
        <el-input v-model="user[0].sex" />
      </el-form-item>
      <el-form-item label="电话">
        <el-input v-model="user[0].phone" />
      </el-form-item>
      <el-form-item label="邮箱">
        <el-input v-model="user[0].email" />
      </el-form-item>
      <el-form-item label="密码">
        <el-input type="password" show-password v-model="user[0].password" />
      </el-form-item>
    </el-form>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="centerDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="editEmployee">
          确定
        </el-button>
      </div>
    </template>
  </el-dialog>

</template>



<script>
export default {
  data() {
    return {
      id: this.$route.query.id,
      user: [{
        name: '',
        sex: '',
        phone: '',
        email: '',
        grade: '',
        hiredate: '',
      }],
      centerDialogVisible: false,
    }
  },
  created() {
    this.selectEmployee();
    console.log(this.id);
  },
  methods: {
    selectEmployee() {
      this.$axios.post('http://localhost:8080/select/selectEmployee', { id: this.id })
        .then(response => {
          this.user = response.data;
          console.log(response.data)
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
    editEmployee() {
      this.$axios.post('http://localhost:8080/edit/editEmployee',
        { 
          id: this.user[0].id,
          name: this.user[0].name,
          sex: this.user[0].sex,
          phone: this.user[0].phone,
          email: this.user[0].email,
          password: this.user[0].password,
        })
        .then(response => {
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
      this.centerDialogVisible = false;
    }
  }
}
</script>


<style scoped></style>
