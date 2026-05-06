<template>
  <section class="page-panel">
    <div class="page-title">
      <div>
        <h2>年度绩效奖金</h2>
        <p>按年度汇总员工绩效奖金和薪资表现。</p>
      </div>
    </div>

    <div class="block">
      <el-date-picker v-model="value3" type="year" value-format="YYYY" placeholder="选择发放年度" />
      <el-button type="primary" plain style="margin-left: 10px;" @click="selectBonus">查询</el-button>
    </div>

    <el-table :data="data" border style="width: 100%">
      <el-table-column prop="employee_id" label="工号" width="180" />
      <el-table-column prop="employee_name" label="姓名" width="180" />
      <el-table-column prop="yearly_bonus" label="年度绩效奖金" />
    </el-table>
  </section>
</template>

<script>
export default {
  data() {
    return {
      value3: '2024',
      data: [],
    }
  },
  created() {
    this.selectBonus();
  },
  methods: {
    selectBonus() {
      this.$axios.post('/select/selectStuffBonus', {  year: this.value3 })
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
