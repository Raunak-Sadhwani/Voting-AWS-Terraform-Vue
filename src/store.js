import { createStore } from "vuex";
// get router
import router from './router';
import  config  from "./config";
const store = createStore({
  state: {
    adminAuth: false,
    host: config.API_ENDPOINT,
    cognitoHost: config.API_COGNITO,
    authMessage: "",
    authError: false,
    updating: true,
    company: {},
    voters: []
  },
  actions: {
    async getVoters(context) {
      const resp = await fetch(`${config.API_ENDPOINT}/voter`);
      const data = await resp.json();
      // check response code
      if (resp.status !== 200) {        
        const payload = {
          error: true,
          message: data.message + " " + (data.error ?? ""),
        }
        context.commit("setAuthError", payload);
      } else {
        context.commit("setVoters", data);
      }
      context.commit("setUpdating", false);
    },
    async vote(context, voteData) {
      // set updating
      context.commit("setUpdating", true);
      const resp = await fetch(`${config.API_ENDPOINT}/voter`, {
        method: "POST",
        body: JSON.stringify(voteData),
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
        context.dispatch("getVoters");
        localStorage.setItem("voted", "true");
      }
      context.commit("setUpdating", false);
    },
    async deleteVoter(context, voterId) {
      // set updating
      context.commit("setUpdating", true);
      const resp = await fetch(`${config.API_ENDPOINT}/voter?voter_id=${voterId}`, {
        method: "DELETE",
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
        context.dispatch("getVoters");
        alert("Voter deleted successfully");
      }
      context.commit("setUpdating", false);
    },
    async getCompany(context) {
      // set updating
      context.commit("setUpdating", true);
      const resp = await fetch(`${config.API_ENDPOINT}/voting`);
      const data = await resp.json();
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
      const resp = await fetch(`${config.API_COGNITO}/login`, userdata);
      const data = await resp.json();
      // check response code
      if (resp.status !== 200) {        
        const payload = {
          error: true,
          message: data.message + " " + (data.error ?? ""),
        }
        context.commit("setAuthError", payload);
      } else {
        localStorage.setItem("token", data.AuthenticationResult.AccessToken);
        context.dispatch("auth", data.AuthenticationResult.AccessToken);
        router.push("/admin/voters");
        // route push
        }
        context.commit("setUpdating", false);

    },
    async auth(context, token) {
      // set updating
      context.commit("setUpdating", true);
      if (token){
        context.commit("setAdminAuth", true);
      }

      // const datax = {
      //   method: "POST",
      //   body: JSON.stringify({ "token": "eyJraWQiOiJxYm40VmNUd2JRZ2xqRGJzNExuYkhkODlWS05aY1FlaVZnNXhxRVNzS3RRPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiIzNGY4ZTQxOC03MDIxLTcwMDQtODBkYS1hNzk0OWRjMmRiMzgiLCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV9yU1hROERNNTIiLCJjbGllbnRfaWQiOiIxdmVlZWJibDdvdjIwcHVtYnFrMmFpdmxpNSIsIm9yaWdpbl9qdGkiOiI5OWU0MWJlZi1mZmNkLTRmNjAtYjIzZC0xODJhOTQwNmQ3ZDciLCJldmVudF9pZCI6IjYyZDUxNmFlLTU0MGEtNDVjYy1hZjk5LTgxYjRlMDA5NzVmMiIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE3MTkzMzM1MTYsImV4cCI6MTcxOTMzNzExNiwiaWF0IjoxNzE5MzMzNTE2LCJqdGkiOiIyNzg3NWY1Ni02MGRkLTQ4NWUtYmYxZS1hMzRlYzRiZDA3NjciLCJ1c2VybmFtZSI6InRlc3QifQ.W2m_wqmCqKRqA5kRht4BrKrbU-U0u3yWwylcCmiuoZ-EpEmmPqsVA3dwIXVhPfrmFdgxcG2BMw2pkdijkF1bHQ_SERb8WmZTK5X3ovMXTpaOl5fAxCO32tOquEUlrAIQcjCw4fIBN85eEWflqRygWKQkgTG896KHaK9xkgoPVcePBBrXPrBHI41z7rdOoakojqzgU6M--2gLyI-tlBIsZP0-KfzsYqFGB2NAezqqxAv8jM4LQNl43QeKXS_IJX-Cl1TETlsaROKqvVk8rENAh9I7izZ8lrgsKXuV02IV4bCYZKbzhyBGevu8Kvumw7byOEcnfADDtbJ35yGNRIXIWA" }),
      // };
      // const resp = await fetch(`https://3uir59f5xc.execute-api.us-east-1.amazonaws.com/prod/verify-token`, datax);
      // // check response code
      // if (resp.status !== 200) {        
      //   const data = await resp.json();
      //   const payload = {
      //     error: true,
      //     message: data.message + " " + (data.error ?? ""),
      //   }
      //   context.commit("setAuthError", payload);
      //   localStorage.removeItem("token");
      // } else {
      //   console.log("auth success");
      //   context.commit("setAdminAuth", true);
      //   localStorage.setItem("token", token);
      // }
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
    setVoters(state, payload) {
      state.voters = payload;
    },
    logout(_){
      localStorage.removeItem("token");
      window.location.href = "/";
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
    voters: (state) => {
      return state.voters;
    },
  },
});

export default store;