<script setup>
</script>

<template>
  <!-- <el-input v-model="input" style="width: 240px" placeholder="Please input" />
  <el-button type="primary" @click="selectEmployee">查询员工</el-button>

  <br>
  <br> -->

  <el-table :data="data" border style="width: 100%">
    <el-table-column prop="id" label="工号" width="180" />
    <el-table-column prop="name" label="姓名" width="180" />
    <el-table-column prop="sex" label="性别" />
  </el-table>
</template>

<style scoped></style>
