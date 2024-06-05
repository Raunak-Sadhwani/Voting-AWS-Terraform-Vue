import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: "/",
      component: () => import("./pages/HomePage.vue"),
    },
    {
        path: "/results",
        component: () => import("./pages/ResultPage.vue"),
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