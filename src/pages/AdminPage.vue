<template>
  
  <section v-if="isDesktop">
    <!-- <transition name="fadeIn"> </transition> -->
    <TheSidebar
      v-if="adminAuth"
      :isSearch="false"
      :profileRole="''"
      :profileName="user.Name"
      :profile-role="user.Comp_name"
      :isUsedVueRouter="true"
      :isPaddingLeft="false"
      :is-menu-open="menu"
      :menu-items="menuItems"
      @update:is-menu-open="updateIsMenuOpen"
      
    />
    <div
      :style="{ paddingLeft: menu ? '280px' : '100px', transition: 'padding-left 0.5s' }"
    >
      <router-view v-slot="slotProps">
        <transition name="route" mode="out-in">
          <keep-alive>
            <component :is="slotProps.Component" />
          </keep-alive>
        </transition>
      </router-view>
    </div>
  </section>
  <section class="mob" v-else>
    <h3>Please View it on Pc or Laptop</h3>
    <br />
    <br />
    <i class="fas fa-desktop"></i>
  </section>
</template>

<script>
// import logo from "../assets/logo.png";
import TheSidebar from "../components/TheSidebar.vue";
export default {
  components: {
    TheSidebar,
  },

  created() {
    window.document.body.style.backgroundColor = "#e3e3e3";
    window.addEventListener("resize", this.handleResize);
    this.handleResize();
    const token = localStorage.getItem("token");
    if (token) {
      this.$store.dispatch("auth", token);
    }
  },
  unmounted() {
    window.removeEventListener("resize", this.handleResize);
  },
  computed: {
    authError() {
      return this.$store.getters.authError;
    },
    authMessage() {
      return this.$store.getters.authMessage;
    },
    adminAuth() {
      return this.$store.getters.adminAuth;
    },
    updating() {
      return this.$store.getters.updating;
    },
  },

  data() {
    return {
      menu: false,
      user: "",
      isDesktop: true,
      menuItems: [
        {
          link: "voters",
          name: "Voters",
          tooltip: "Voters",
          icon: "bx-group",
        },
      ],
    };
  },
  methods: {
    updateIsMenuOpen(isMenuOpen) {
      this.menu = isMenuOpen;
    },
    handleResize() {
      this.isDesktop = window.innerWidth >= 768; // change 768 to the breakpoint for your desktop layout
    },
    handleError() {
      this.$store.commit("setAuthError", {
        error: null,
        message: "",
      });
    },
  },
};
</script>

<style scoped>
.mob {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  flex-direction: column;
  font-size: 1.5rem;
  text-align: center;
}
.mob i {
  font-size: 5rem;
}
</style>
