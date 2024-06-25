import { createRouter, createWebHistory } from "vue-router";
import { defineAsyncComponent } from "vue";
import store from "./store.js";
const AdminPage = defineAsyncComponent(() => import("./pages/AdminPage.vue"));
const AdminUserPage = defineAsyncComponent(() =>
  import("./pages/admin/AdminUserPage.vue")
);
const AdminLoginPage = defineAsyncComponent(() =>
  import("./pages/admin/AdminLoginPage.vue")
);

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: "/",
      alias: "/home",
      component: () => import("./pages/HomePage.vue"),
    },
    {
      path: "/results",
      component: () => import("./pages/ResultPage.vue"),
    },
    {
      path: "/admin",
      redirect: { name: "adminUser" },
      name: "admin",
      component: AdminPage,
      children: [
        {
          path: "login",
          name: "adminLogin",
          component: AdminLoginPage,
          meta: {
            requiresAdminUnauth: true,
          },
        },
        {
          path: "voters",
          name: "adminUser",
          component: AdminUserPage,
          meta: {
            requiresAdminAuth: true,
          },
        },
        {
          path: "/:pathMatch(.*)*",
          name: "not-found",
          component: () => import("./pages/NotFound.vue"),
        },
      ],
    },
    {
      path: "/:pathMatch(.*)*",
      name: "not-found",
      component: () => import("./pages/NotFound.vue"),
    },
  ],
});

router.beforeEach((to, from, next) => {
  const admin = store.getters.adminAuth;
// if admin is not authenticated, then push to login page, else go to voters page
  if (to.matched.some((record) => record.meta.requiresAdminAuth)) {
    if (!admin && !localStorage.getItem("token")) {
      next({ name: "adminLogin" });
    }  else {
      next();
    }
  } else if (to.matched.some((record) => record.meta.requiresAdminUnauth)) {
    if (admin || localStorage.getItem("token")) {
      next({ name: "adminUser" });
    }  else {
      next();
    }
  } else {
    next();
  }
});

export default router;
