import { createApp } from "vue";

import router from "./router.js";
import store from "./store.js";
import axios from 'axios'
import VueAxios from 'vue-axios'
import App from "./App.vue";

const app = createApp(App);
app.use(router);
app.use(store);
app.use(VueAxios, axios)
app.mount("#app");