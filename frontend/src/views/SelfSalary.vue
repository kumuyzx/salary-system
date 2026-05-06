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
    <el-table-column prop="month" label="月份" />
    <el-table-column prop="wage" label="岗位工资" />
    <el-table-column prop="subsidy" label="加班补贴" />
    <el-table-column prop="bonus" label="绩效奖金" />
    <el-table-column prop="from_checking_in" label="考勤调整" />
    <el-table-column prop="deductMoney" label="社保公积金" />
    <el-table-column prop="before_tax" label="应税工资" />
    <el-table-column prop="tax" label="个人所得税" />
    <el-table-column prop="total" label="实发工资" />
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
      this.$axios.post('/select/selectSalary', { 
        start: this.value1[0],
        end: this.value1[1],
        id: this.id })
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
