<template>

  <div class="block">
    <el-input v-model="input" style="width: 240px" placeholder="请输入员工号" />
    <el-button type="primary" plain style="margin-left: 10px;" @click="selectInfo">查询</el-button>
  </div>

  <br>

  <el-table :data="data" border style="width: 100%">
    <el-table-column prop="id" label="工号" />
    <el-table-column prop="name" label="姓名" />
    <el-table-column prop="sex" label="性别" />
    <el-table-column prop="phone" label="电话号码" />
    <el-table-column prop="email" label="邮箱" />
    <el-table-column prop="grade" label="职级" />
    <el-table-column prop="Dname" label="部门" />
    <el-table-column fixed="right" label="操作" width="120">
      <template #default="scope">
        <el-button type="info" size="small" @click="reset(scope.row)">重置密码</el-button>
      </template>
    </el-table-column>
  </el-table>
</template>

<script>
export default {
  data() {
    return {
      input: '',
      data: [],
    }
  },
  created() {
    this.selectInfo();
  },
  methods: {
    selectInfo() {
      this.$axios.post('http://localhost:8080/select/selectStuffInfo', {  id: this.input })
        .then(response => {
          this.data = response.data;
          console.log(response.data)
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
    reset(row) {
      this.$axios.post('http://localhost:8080/edit/resetPassword', {  id: row.id })
        .then(response => {
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
  }
}
</script>


<style scoped></style>