<template>
  <section v-if="isDesktop">
    <BaseSpinner v-if="updating"/>
    <base-dialog :show="!!authError" title="Something Happened" @close="handleError">
      <p>{{ authMessage }}</p>
    </base-dialog>
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
import { mapGetters } from "vuex";
import TheSidebar from "../components/TheSidebar.vue";
import BaseSpinner from "../components/BaseSpinner.vue";
import BaseDialog from "../components/BaseDialog.vue";

export default {
  components: {
    TheSidebar,
  },

  created() {
    // console.log(this)
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
    ...mapGetters(["authError", "authMessage", "adminAuth", "updating"]),
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
