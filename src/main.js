import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import vuetify from './plugins/vuetify'

const app = createApp(App)

// 确保按正确顺序使用插件
app.use(vuetify)
app.use(router)

// 确保挂载到正确的元素
app.mount('#app')
