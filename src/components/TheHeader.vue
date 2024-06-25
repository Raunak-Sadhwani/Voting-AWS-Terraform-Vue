<template>
  <div class="header container-fluid bg-white">
    <div id="menu-jk" class="nav-col text-white shadow-md mb-3">
      <div class="container">
        <div class="row">
          <div
            class="col-lg-6 pt-2 pb-2 align-items-center"
            @click="$router.push('/')"
            style="cursor: pointer"
          >
            <!-- <img class="max-230 mt-2" src="../assets/images/logo.png" alt=""> -->
            <h1 class="fs-4 mt-2 fw-bold">VX Company</h1>
          </div>
          <div id="menu" class="col-lg-6 d-none d-lg-block">
            <ul class="float-end mul d-inline-block">
              <li class="float-md-start px-4 pe-1 pt-4" v-if="!results">
                <a href="#about" class="fw-bold fs-8 text-primary"> About Us</a>
              </li>
              <li class="float-md-start px-4 pe-1 pt-4" v-if="!results">
                <router-link to="/results" class="fw-bold fs-8 text-primary">
                  View Result</router-link
                >
              </li>
              <li class="float-md-start px-4 pe-1 py-3">
                <button
                  class="btn fw-bold fs-8 btn-outline-primary px-5"
                  @click="$router.push({ name: 'adminUser' })"
                >
                  Login
                </button>
              </li>
              <!-- <li class="float-md-start px-4 pe-1 py-3">
                <button
                  class="btn fw-bold fs-8 btn-primary"
                  data-bs-toggle="modal"
                  data-bs-target="#exampleModal2"
                >
                  Register your company
                </button>
              </li> -->
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    results: {
      type: Boolean,
      default: false,
    },
  },
};
</script>

<style lang="scss" scoped></style>
