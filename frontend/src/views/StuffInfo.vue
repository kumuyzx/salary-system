<template>
  <section class="page-panel">
    <div class="page-title">
      <div>
        <h2>员工档案</h2>
        <p>查询员工基本信息、岗位职级和账号维护状态。</p>
      </div>
    </div>

    <div class="block">
      <el-input v-model="input" style="width: 240px" placeholder="输入工号筛选，留空查看全部" />
      <el-button type="primary" plain style="margin-left: 10px;" @click="selectInfo">查询</el-button>
    </div>

    <el-table :data="data" border style="width: 100%">
      <el-table-column prop="id" label="工号" />
      <el-table-column prop="name" label="姓名" />
      <el-table-column prop="sex" label="性别" />
      <el-table-column prop="phone" label="联系电话" />
      <el-table-column prop="email" label="企业邮箱" />
      <el-table-column prop="grade" label="岗位职级" />
      <el-table-column prop="Dname" label="部门" />
      <el-table-column fixed="right" label="账号维护" width="120">
        <template #default="scope">
          <el-button type="info" size="small" @click="reset(scope.row)">重置密码</el-button>
        </template>
      </el-table-column>
    </el-table>
  </section>
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
      this.$axios.post('/select/selectStuffInfo', {  id: this.input })
        .then(response => {
          this.data = response.data;
          console.log(response.data)
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
    reset(row) {
      this.$axios.post('/edit/resetPassword', {  id: row.id })
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
