<script>
export default {
  async created() {
    // await this.$store.dispatch(
    //   "login",
    //   JSON.stringify({
    //     Email: "xyz@sd.io",
    //     Password: "123456",
    //   })
    // );
    // this.$store.dispatch("auth", "token");
  },
};
</script>

<template>
  <div id="app">
    <body>
      <router-view />
    </body>
  </div>
</template>
