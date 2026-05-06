<template>
  <div class="app-shell">
    <header class="app-header">
      <div class="brand">
        <div class="brand-mark">薪</div>
        <div>
          <h1>企业薪酬管理平台</h1>
          <p>薪资、奖金、考勤与员工档案</p>
        </div>
      </div>

      <div class="header-actions">
        <div class="user-card">
          <el-avatar :size="36" class="user-avatar">
            {{ name === '未登录' ? '访' : name.slice(0, 1) }}
          </el-avatar>
          <div class="user-meta">
            <strong>{{ name }}</strong>
            <span>{{ id.trim() || '未分配工号' }}</span>
          </div>
          <el-tag effect="light" round>{{ status[power] }}</el-tag>
        </div>
        <el-button v-if="power === '0'" type="primary" @click="handleLogin">
          登录
        </el-button>
        <el-button v-else type="danger" plain @click="logout">
          注销
        </el-button>
      </div>
    </header>

    <div class="app-body">
      <aside class="app-sidebar">
        <el-menu
          ref="menu"
          :default-active="menuActive"
          class="app-menu"
          @open="handleOpen"
          @close="handleClose"
        >
          <el-sub-menu index="1" :disabled="power1">
            <template #title>
              <el-icon><User /></el-icon>
              <span>个人中心</span>
            </template>
            <el-menu-item index="1-1" id="selfInfo" @click="goSelfInfo">我的档案</el-menu-item>
            <el-menu-item index="1-2" @click="goSelfSalary">我的薪资</el-menu-item>
          </el-sub-menu>
          <el-sub-menu index="2" :disabled="power2">
            <template #title>
              <el-icon><Money /></el-icon>
              <span>薪酬财务</span>
            </template>
            <el-menu-item index="2-1" @click="goStuffSalary">薪资台账</el-menu-item>
            <el-menu-item index="2-2" @click="goStuffBonus">年度绩效奖金</el-menu-item>
          </el-sub-menu>
          <el-sub-menu index="3" :disabled="power3">
            <template #title>
              <el-icon><OfficeBuilding /></el-icon>
              <span>人力资源</span>
            </template>
            <el-menu-item index="3-1" @click="goStuffInfo">员工档案</el-menu-item>
            <el-menu-item index="3-2" @click="goStuffChecking">考勤维护</el-menu-item>
          </el-sub-menu>
        </el-menu>
      </aside>

      <main class="app-content">
        <router-view />
      </main>
    </div>

    <el-dialog v-model="dialogFormVisible" title="员工账号登录" width="420" class="login-dialog">
      <div class="login-copy">
        <h2>欢迎回来</h2>
        <p>请输入员工工号和密码访问平台。</p>
      </div>
      <el-form :model="form" label-position="top" hide-required-asterisk="true">
        <el-form-item label="工号" prop="id">
          <el-input v-model="form.id" placeholder="例如 1001" @keyup.enter="login" />
        </el-form-item>
        <el-form-item label="密码" prop="pass">
          <el-input v-model="form.pass" type="password" autocomplete="off" show-password @keyup.enter="login" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取消</el-button>
          <el-button type="primary" @click="login">登录</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>


<script>
import { Money, OfficeBuilding, User } from '@element-plus/icons-vue';
import { ElMessage } from 'element-plus';

export default {
  name: 'Select',
  components: {
    Money,
    OfficeBuilding,
    User,
  },
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
      if (!this.form.id) {
        ElMessage.error('请输入工号');
        return;
      }
      if (this.form.id.length !== 4) {
        ElMessage.error('请输入4位员工号');
        return;
      }
      if (!this.form.pass) {
        ElMessage.error('请输入密码');
        return;
      }
      if (this.form.pass.length < 6 || this.form.pass.length > 18) {
        ElMessage.error('请输入6到18位的密码');
        return;
      }
      this.goHome();
      this.$axios.post('/login/loginToSystem', { id: this.form.id, pass: this.form.pass })
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
            ElMessage.error('工号或密码错误，请重新输入');
            this.goHome();
          }
        })
        .catch(error => {
          console.error('Error fetching data:', error);
          ElMessage.error('登录失败，请稍后重试');
        });
    },
    handleOpen(key) {
      this.menuList.push(key);
    },
    handleClose(key) {
      this.menuList = this.menuList.filter(item => item !== key);
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
      this.$axios.post('/select/selectEmployee', { name: this.input })
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
.app-shell {
  min-height: 100vh;
  background:
    linear-gradient(180deg, rgba(37, 99, 235, 0.06), rgba(37, 99, 235, 0) 320px),
    var(--app-bg);
}

.app-header {
  position: sticky;
  top: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  min-height: 72px;
  padding: 12px 24px;
  background: rgba(255, 255, 255, 0.94);
  border-bottom: 1px solid var(--app-border);
  backdrop-filter: blur(14px);
}

.brand {
  display: flex;
  align-items: center;
  gap: 12px;
  min-width: 0;
}

.brand-mark {
  display: grid;
  flex: 0 0 auto;
  width: 42px;
  height: 42px;
  place-items: center;
  color: #fff;
  background: var(--app-primary);
  border-radius: 8px;
  font-weight: 800;
  box-shadow: 0 10px 24px rgba(37, 99, 235, 0.24);
}

.brand h1 {
  color: var(--app-heading);
  font-size: 19px;
  font-weight: 800;
  letter-spacing: 0;
  line-height: 1.2;
}

.brand p {
  color: var(--app-muted);
  font-size: 12px;
  line-height: 1.4;
  margin-top: 2px;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.user-card {
  display: flex;
  align-items: center;
  gap: 10px;
  min-width: 0;
  padding: 6px 10px;
  background: var(--app-surface-soft);
  border: 1px solid var(--app-border);
  border-radius: 8px;
}

.user-avatar {
  color: var(--app-primary);
  background: var(--app-primary-soft);
  font-weight: 800;
}

.user-meta {
  display: grid;
  min-width: 0;
  line-height: 1.25;
}

.user-meta strong {
  max-width: 120px;
  overflow: hidden;
  color: var(--app-heading);
  font-size: 13px;
  font-weight: 700;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.user-meta span {
  color: var(--app-muted);
  font-size: 12px;
}

.app-body {
  display: grid;
  grid-template-columns: 236px minmax(0, 1fr);
  gap: 20px;
  max-width: 1440px;
  margin: 0 auto;
  padding: 20px 24px 28px;
}

.app-sidebar {
  position: sticky;
  top: 92px;
  align-self: start;
  overflow: hidden;
  background: var(--app-surface);
  border: 1px solid var(--app-border);
  border-radius: var(--app-radius);
  box-shadow: var(--app-shadow);
}

.app-menu {
  width: 100%;
  border-right: 0;
  padding: 8px;
}

.app-menu .el-sub-menu__title,
.app-menu .el-menu-item {
  border-radius: 6px;
}

.app-menu .el-menu-item.is-active {
  color: var(--app-primary);
  background: var(--app-primary-soft);
  font-weight: 700;
}

.app-content {
  min-width: 0;
}

.login-copy {
  margin-bottom: 18px;
}

.login-copy h2 {
  color: var(--app-heading);
  font-size: 22px;
  font-weight: 800;
  line-height: 1.25;
}

.login-copy p {
  color: var(--app-muted);
  font-size: 13px;
  margin-top: 4px;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
}

@media (max-width: 900px) {
  .app-header {
    align-items: flex-start;
    flex-direction: column;
    padding: 12px 14px;
  }

  .header-actions {
    width: 100%;
    justify-content: space-between;
  }

  .user-card {
    flex: 1;
  }

  .app-body {
    grid-template-columns: 1fr;
    gap: 12px;
    padding: 12px 0 20px;
  }

  .app-sidebar {
    position: static;
    border-left: 0;
    border-right: 0;
    border-radius: 0;
    box-shadow: none;
  }

  .app-menu {
    padding: 6px 10px;
  }

  .app-content {
    overflow-x: hidden;
  }

  .el-table {
    min-width: 760px;
  }

  .login-dialog {
    --el-dialog-width: min(300px, 80vw);
    --el-dialog-margin-top: 14vh;
  }

  .login-dialog :deep(.el-dialog__body) {
    padding: 10px 14px 2px;
  }

  .login-dialog :deep(.el-dialog__header) {
    padding: 14px 14px 0;
  }

  .login-dialog :deep(.el-dialog__footer) {
    padding: 6px 14px 14px;
  }
}

@media (max-width: 520px) {
  .brand h1 {
    font-size: 17px;
  }

  .brand p {
    display: none;
  }

  .header-actions {
    align-items: center;
    flex-direction: row;
    gap: 8px;
  }

  .header-actions > .el-button {
    flex: 0 0 auto;
    width: auto;
  }

  .dialog-footer {
    flex-direction: column-reverse;
  }

  .dialog-footer .el-button {
    width: 100%;
    margin-left: 0 !important;
  }
}
</style>
