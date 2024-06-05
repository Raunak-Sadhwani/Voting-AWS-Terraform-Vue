import { createRouter, createWebHistory } from "vue-router";
import { defineAsyncComponent } from "vue";
const AdminPage = defineAsyncComponent(() => import("./pages/AdminPage.vue"));
const AdminUserPage = defineAsyncComponent(() =>
  import("./pages/admin/AdminUserPage.vue")
);
const AdminDashboardPage = defineAsyncComponent(() =>
  import("./pages/admin/AdminDashboardPage.vue")
);
const AdminVotingPage = defineAsyncComponent(() =>
  import("./pages/admin/AdminVotingPage.vue")
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
      redirect: { name: "adminDashboard" },
      name: "admin",
      meta: {
        // requiresAdminUnauth: true,
      },
      component: AdminPage,
      children: [
        {
          path: "dashboard",
          name: "adminDashboard",
          component: AdminDashboardPage,
          meta: {
            requiresAdminAuth: true,
          },
        },
        {
          path: "staff",
          name: "adminUser",
          component: AdminUserPage,
          meta: {
            requiresAdminAuth: true,
          },
        },
        {
          path: "voting",
          name: "voting",
          component: AdminVotingPage,
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
    // {
    //   path: "/:id",
    //   component: () => import("./pages/ChatUI.vue"),
    //   props: true,
    // },
    // {
    //   name: "about",
    //   path: "/about",
    //   component: () => import("./pages/AboutMe.vue"),
    // },
    {
      path: "/:pathMatch(.*)*",
      name: "not-found",
      component: () => import("./pages/NotFound.vue"),
    },
  ],
});

export default router;
