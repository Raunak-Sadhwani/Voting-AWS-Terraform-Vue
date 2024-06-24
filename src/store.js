import { createStore } from "vuex";
// get config.js

import  config  from "../public/config";
const store = createStore({
  state: {
    adminAuth: false,
    host: config.API_ENDPOINT,
    authMessage: "",
    authError: false,
    updating: true,
    company: {
      company_id: "123456789",
      name: "Acme Inc.",
      email: "info@acme.com",
      voting_role: "President",
      description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu nibh et felis interdum accumsan. Pellentesque elit odio, interdum quis ante in, varius rhoncus orci.",
      users: [
        {
          user_id: "user1",
          user_name: "Alice",
          user_email: "alice@example.com",
          user_votes: 100,
          user_description:
            " Aliquam utrum nibh rutrum nibh vitae tortor dapibus egestas. Cras condimentum dapibus tellus vel semper. Quisque vel dui molestie est auctor utrum nibh porttitor.",
          user_manifesto:
            "1. Innovate healthcare technology.\n2. Improve patient outcomes.\n3. Enhance operational efficiency.\n4. Promote patient-centered care.\n5. Ensure healthcare accessibility.",
        },
        {
          user_id: "user2",
          user_name: "Bob",
          user_votes: 200,
          user_email: "bob@example.com",
          user_description:
            " Aliquam utrum nibh rutrum nibh vitae tortor dapibus egestas. Cras condimentum dapibus tellus vel semper. Quisque vel dui molestie est auctor utrum nibh porttitor.",
          user_manifesto:
            "1. Innovate healthcare technology.\n2. Improve patient outcomes.\n3. Enhance operational efficiency.\n4. Promote patient-centered care.\n5. Ensure healthcare accessibility.",
        },
      ],
    },
  },
  actions: {
    async login(context, userdata) {
      // set updating
      context.commit("setUpdating", true);
      const resp = await fetch(`${context.getters.host}login/`, {
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
      const resp = await fetch(`${context.getters.host}verify-token`, {
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
    }
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