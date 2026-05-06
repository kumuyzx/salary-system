import { VueElement, createApp } from 'vue'
import router from './router'
import ElementPlus from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import 'element-plus/theme-chalk/index.css'
import request from './utils/request'
import App from './App.vue'

const app = createApp(App)

app.config.globalProperties.$axios = request

app.use(ElementPlus, {
    locale: zhCn,
})


app.use(router).mount('#app')
