<template>
  <section class="page-panel">
    <div class="page-title">
      <div>
        <h2>考勤维护</h2>
        <p>维护员工月度加班、请假、迟到和早退记录。</p>
      </div>
    </div>

    <div class="block">
      <el-input v-model="input" style="width: 240px" placeholder="输入工号筛选，留空查看全部" />
      <el-button type="primary" plain style="margin-left: 10px;" @click="selectInfo">查询</el-button>
    </div>

    <el-table :data="data" border style="width: 100%">
      <el-table-column prop="id" label="工号" />
      <el-table-column prop="name" label="姓名" />
      <el-table-column prop="month" label="月份" />
      <el-table-column prop="over_hours" label="工作日加班(小时)" />
      <el-table-column prop="weekend_overtime" label="周末加班(小时)" />
      <el-table-column prop="holiday_overtime" label="节假日加班(小时)" />
      <el-table-column prop="late_day" label="迟到(次)" />
      <el-table-column prop="early_leave" label="早退(次)" />
      <el-table-column fixed="right" label="维护" width="120">
        <template #default="scope">
          <el-button type="info" size="small" @click="edit(scope.row)">编辑</el-button>
        </template>
      </el-table-column>
    </el-table>
  </section>

  <el-dialog align-center="true" v-model="centerDialogVisible" title="考勤记录维护" width="400" center>

    <el-form ref="ruleFormRef" style="max-width: 300px" :model="ruleForm" status-icon :rules="rules" label-width="auto"
      class="demo-ruleForm">
      <el-form-item label="工号">
        <el-input v-model="id" disabled />
      </el-form-item>
      <el-form-item label="姓名">
        <el-input v-model="name" disabled />
      </el-form-item>
      <el-form-item label="月份">
        <el-input v-model="month" disabled />
      </el-form-item>
      <el-form-item label="工作日加班">
        <el-input-number v-model="over_hours" :min="0" :max="1000" />
      </el-form-item>
      <el-form-item label="周末加班">
        <el-input-number v-model="weekend_overtime" :min="0" :max="1000" />
      </el-form-item>
      <el-form-item label="节假日加班">
        <el-input-number v-model="holiday_overtime" :min="0" :max="1000" />
      </el-form-item>
      <el-form-item label="请假天数">
        <el-input-number v-model="leave_day" :min="0" :max="1000" />
      </el-form-item>
      <el-form-item label="迟到次数">
        <el-input-number v-model="late_day" :min="0" :max="1000" />
      </el-form-item>
      <el-form-item label="早退次数">
        <el-input-number v-model="early_leave" :min="0" :max="1000" />
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="centerDialogVisible = false">取消</el-button>
        <el-button id="selectButton" type="primary" @click="editChecking">
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
      input: '',
      centerDialogVisible: false,
      id: '123',
      name: '',
      month: '',
      over_hours: '',
      weekend_overtime: '',
      holiday_overtime: '',
      leave_day: '',
      late_day: '',
      early_leave: '',
      data: [],
    }
  },
  created() {
    this.selectInfo();
  },
  methods: {
    selectInfo() {
      this.$axios.post('/select/selectStuffChecking', { id: this.input })
        .then(response => {
          this.data = response.data;
          console.log(response.data)
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
    edit(row) {
      this.id = row.id;
      this.name = row.name;
      this.month = row.month;
      this.over_hours = row.over_hours;
      this.weekend_overtime = row.weekend_overtime;
      this.holiday_overtime = row.holiday_overtime;
      this.leave_day = row.leave_day;
      this.late_day = row.late_day;
      this.early_leave = row.early_leave;
      this.centerDialogVisible = true;
    },
    editChecking() {
      console.log(this.early_leave)
      this.$axios.post('/edit/editChecking',
        {
          id: this.id,
          name: this.name,
          month: this.month,
          over_hours: this.over_hours,
          weekend_overtime: this.weekend_overtime,
          holiday_overtime: this.holiday_overtime,
          leave_day: this.leave_day,
          late_day: this.late_day,
          early_leave: this.early_leave
        })
        .then(response => {
          this.selectInfo();
          this.centerDialogVisible = false;
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    }
  }
}
</script>


<style scoped></style>
