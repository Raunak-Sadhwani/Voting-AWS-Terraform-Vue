import { createStore } from "vuex";
// get config.js

import  config  from "./config";
const store = createStore({
  state: {
    adminAuth: false,
    host: config.API_ENDPOINT,
    authMessage: "",
    authError: false,
    updating: true,
    company: {}
  },
  actions: {
    async getCompany(context) {
      // set updating
      console.log(context.getters.host);
      context.commit("setUpdating", true);
      const resp = await fetch(`https://1kr1ifban0.execute-api.us-east-1.amazonaws.com/prod/voting`, {
       
      });
      const data = await resp.json();
      console.log(data);
      // check response code
      if (resp.status !== 200) {        
        const payload = {
          error: true,
          message: data.message + " " + (data.error ?? ""),
        }
        context.commit("setAuthError", payload);
      } else {
        context.commit("setCompany", data[0]);
      }
      context.commit("setUpdating", false);
    },
    async login(context, userdata) {
      // set updating
      context.commit("setUpdating", true);
      const resp = await fetch(`https://3uir59f5xc.execute-api.us-east-1.amazonaws.com/prod/login`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(userdata),
      });
      const data = await resp.json();
      // check response code
      if (resp.status !== 200) {        
        const payload = {
          error: true,
          message: data.message + " " + (data.error ?? ""),
        }
        context.commit("setAuthError", payload);
      } else {
        context.dispatch("auth", data.AccessToken);
        }
      context.commit("setUpdating", false);

    },
    async auth(context, token) {
      // set updating
      context.commit("setUpdating", true);
      const resp = await fetch(`https://3uir59f5xc.execute-api.us-east-1.amazonaws.com/prod/verify-token`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ "token": token }),
      });
      // check response code
      if (resp.status !== 200) {        
        const data = await resp.json();
        const payload = {
          error: true,
          message: data.message + " " + (data.error ?? ""),
        }
        context.commit("setAuthError", payload);
        localStorage.removeItem("token");
      } else {
        context.commit("setAdminAuth", true);
        localStorage.setItem("token", token);
      }
      context.commit("setUpdating", false);
    },
  },
  mutations: {
   setAuthError(state, payload) {
      state.authError = payload.error;
      state.authMessage = payload.message;
    },
    setAdminAuth(state, payload) {
      state.adminAuth = payload;
    },
    setUpdating(state, payload) {
      state.updating = payload;
    },
    setCompany(state, payload) {
      state.company = payload;
    },
  },
  getters: {
    getCompany: (state) => {
      return state.company;
    },
    adminAuth: (state) => {
      return state.adminAuth;
    },
    host: (state) => {
      return state.host;
    },
    authMessage: (state) => {
      return state.authMessage;
    },
    authError: (state) => {
      return state.authError;
    },
    updating: (state) => {
      return state.updating;
    },
  },
});

export default store;