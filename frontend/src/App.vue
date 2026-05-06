<template>
  <div class="common-layout">
    <el-container>
      <el-header>
        <el-page-header :icon="null" title="企业薪酬管理平台">
          <template #content>
            <div class="flex items-center">
              <el-avatar :size="32" class="mr-3"
                src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png" />
              <span class="text-large font-600 mr-3" style="margin: 5px;"> {{ name }} </span>
              <span class="text-sm mr-2" style="color: var(--el-text-color-regular); margin: 5px;">
                {{ id }}
              </span>
              <el-tag style="margin: 5px;">{{ status[power] }}</el-tag>
            </div>
          </template>
          <template #extra>
            <div class="flex items-center">
              <el-button v-if="power === '0'" type="primary" @click="handleLogin">登录</el-button>
              <el-button v-else type="danger" @click="logout">注销</el-button>
            </div>
          </template>
        </el-page-header>
      </el-header>
      <el-container>
        <el-aside width="200px">
          <el-row class="tac">
            <el-col :span="12">
              <el-menu ref="menu" :default-active="menuActive" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose">
                <el-sub-menu index="1" :disabled="power1">
                  <template #title>
                    <span>个人中心</span>
                  </template>
                  <el-menu-item index="1-1" id="selfInfo" @click="goSelfInfo">我的档案</el-menu-item>
                  <el-menu-item index="1-2" @click="goSelfSalary">我的薪资</el-menu-item>
                </el-sub-menu>
                <el-sub-menu index="2" :disabled="power2">
                  <template #title>
                    <span>薪酬财务</span>
                  </template>
                  <el-menu-item index="2-1" @click="goStuffSalary">薪资台账</el-menu-item>
                  <el-menu-item index="2-2" @click="goStuffBonus">年度绩效奖金</el-menu-item>
                </el-sub-menu>
                <el-sub-menu index="3" :disabled="power3">
                  <template #title>
                    <span>人力资源</span>
                  </template>
                  <el-menu-item index="3-1" @click="goStuffInfo">员工档案</el-menu-item>
                  <el-menu-item index="3-2" @click="goStuffChecking">考勤维护</el-menu-item>
                </el-sub-menu>
              </el-menu>
            </el-col>
          </el-row>
        </el-aside>
        <el-main>
          <router-view />
        </el-main>
      </el-container>

      <el-dialog v-model="dialogFormVisible" title="员工账号登录" width="400" height="">
        <el-form :model="form" label-position="left" hide-required-asterisk="true">
          <el-form-item label="工号" :label-width="formLabelWidth" prop="id" :rules="[
            { required: true, message: '请输入工号', trigger: 'blur' },
            { min: 4, max: 4, message: '请输入4位员工号', trigger: 'blur' },
          ]">
            <el-input v-model="form.id" />
          </el-form-item>
          <el-form-item label="密码" :label-width="formLabelWidth" prop="pass" :rules="[
            { required: true, message: '请输入密码', trigger: 'blur' },
            { min: 6, max: 18, message: '请输入6到18位的密码', trigger: 'blur' },
          ]">
            <el-input v-model="form.pass" type="password" autocomplete="off" />
          </el-form-item>
        </el-form>
        <template #footer>
          <div class="dialog-footer">
            <el-button type="primary" @click="login">
              登录
            </el-button>
            <el-button @click="dialogFormVisible = false">
              取消
            </el-button>
          </div>
        </template>
      </el-dialog>

    </el-container>
  </div>
</template>


<script>
import { selectWords } from './api/post';
import { Location, Setting, Menu, Document } from '@element-plus/icons-vue';

export default {
  name: 'Select',
  data() {
    return {
      dialogFormVisible: false,
      form: {
        id: '',
        pass: '',
        delivery: false,
        type: [],
        resource: '',
        desc: ''
      },
      formLabelWidth: '120px',
      input: '',
      name: '未登录',
      id: ' ',
      power: '0',
      status: ["访客", "员工", "财务专员", "人事专员"],
      allMenusCollapsed: '',
      menuActive: '',
      keyIndex: '',
      menuList: [],
      power1: true,
      power2: true,
      power3: true,
      data: [],
    }
  },
  created() {
    this.goHome();
  },
  methods: {
    goHome() {
      this.$router.push('/')
    },
    goSelfInfo() {
      this.$router.push({ path: "/SelfInfo", query: { id: this.id } })
    },
    goSelfSalary() {
      //this.$router.push('/SelfSalary')
      this.$router.push({ path: "/SelfSalary", query: { id: this.id }})
    },
    goStuffSalary() {
      this.$router.push('/StuffSalary')
    },
    goStuffBonus() {
      this.$router.push('/StuffBonus')
    },
    goStuffInfo() {
      this.$router.push('/StuffInfo')
    },
    goStuffChecking() {
      this.$router.push('/StuffChecking')
    },
    handleLogin() {
      this.dialogFormVisible = true;
      this.form.pass = '';
    },
    login() {
      this.goHome();
      this.$axios.post('http://localhost:8080/login/loginToSystem', { id: this.form.id, pass: this.form.pass })
        .then(response => {
          var data = response.data
          if (data.length == 1) {
            this.name = data[0].name;
            this.id = data[0].id;
            this.power = data[0].power;
            switch (this.power) {
              case "3":
                this.power3 = false;
              case "2":
                this.power2 = false;
              case "1":
                this.power1 = false;
                break;
              default:
                break;
            }
            document.getElementById('selfInfo').click();
            this.dialogFormVisible = false;
          } else {
            this.name = '未登录';
            this.id = ' ';
            this.power = '0';
            this.power1 = true;
            this.power2 = true;
            this.power3 = true;
            this.goHome();
          }
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
    handleOpen(key) {
      this.menuList.push(key);
    },
    logout() {
      this.menuActive = '';
      for (var i = 0; i < this.menuList.length; i ++) {
        this.$refs.menu.close(this.menuList[i]);
      }
      this.name = '未登录';
      this.id = ' ';
      this.power = '0';
      this.power1 = true;
      this.power2 = true;
      this.power3 = true;
      this.goHome();
    },
    selectEmployee() {
      this.$axios.post('http://localhost:8080/select/selectEmployee', { name: this.input })
        .then(response => {
          this.data = response.data;
        })
        .catch(error => {
          console.error('Error fetching data:', error);
        });
    },
  }
}

</script>

<style>
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  min-height: 400px;
}

.el-header {
  --el-header-padding: 0 20px;
  --el-header-height: 60px;
  box-sizing: border-box;
  flex-shrink: 0;
  height: var(--el-header-height);
  padding: 0px;
}

.el-dialog {
  --el-dialog-margin-top: 30vh;
}
</style>
