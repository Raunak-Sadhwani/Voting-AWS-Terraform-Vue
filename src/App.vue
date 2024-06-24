<script>
export default {
  async created() {
    // https://k17l3ph5r8.execute-api.us-east-1.amazonaws.com/prod/login/
    const resp = await fetch(
      "https://k17l3ph5r8.execute-api.us-east-1.amazonaws.com/prod/verify-tok",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
    const data = await resp.json();
    console.log(resp);
    console.log(data);
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
