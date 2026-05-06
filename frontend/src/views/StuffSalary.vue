<template>

  <div class="block">
      <el-date-picker
        v-model="value1"
        type="monthrange"
        range-separator="至"
        value-format='YYYY-MM-DD'
        start-placeholder="开始月份"
        end-placeholder="结束月份"
      />
      <el-button type="primary" plain style="margin-left: 10px;" @click="selectSalary">查询</el-button>
  </div>

  <br>

  <el-table :data="data" border style="width: 100%">
    <el-table-column prop="id" label="员工号" />
    <el-table-column prop="name" label="姓名" />
    <el-table-column prop="Dname" label="部门" />
    <el-table-column prop="month" label="月份" />
    <el-table-column prop="wage" label="基本工资" />
    <el-table-column prop="subsidy" label="加班津贴" />
    <el-table-column prop="bonus" label="奖金" />
    <el-table-column prop="from_checking_in" label="考勤" />
    <el-table-column prop="deductMoney" label="五险一金" />
    <el-table-column prop="before_tax" label="税前" />
    <el-table-column prop="tax" label="税" />
    <el-table-column prop="total" label="税后" />
  </el-table>
</template>

<script>
export default {
  data() {
    return {
      id: this.$route.query.id,
      value1: ['2024-01', '2024-06'],
      data: [],
    }
  },
  created() {
    this.selectSalary();
  },
  methods: {
    selectSalary() {
      this.$axios.post('http://localhost:8080/select/selectStuffSalary', { 
        start: this.value1[0],
        end: this.value1[1], })
        .then(response => {
          this.data = response.data;
          console.log(response.data)
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
  }
}
</script>


<style scoped></style>
