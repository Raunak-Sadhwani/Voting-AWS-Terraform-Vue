<template>
  <section>
    <TheHeader :results="true" />

    <div class="container py-5 big-padding">
      <div class="row section-title">
        <h2 class="fs-5 text-center">{{ company.name }} Voting Result</h2>
        <p>The below chart shows the voting results of the {{ company.name }}. <br /></p>
      </div>
      <div class="row mb-5">
        <div class="col-md-6 mb-4" v-for="user in company.users" :key="user.company_id">
          <div class="row shado-md p-2 m-0 rounded shadow-md bg-white">
            <div class="col-md-3">
              <img class="rounded-pill max-130 p-2" :src="user.user_image" alt="" />
            </div>
            <div class="col-md-9 align-self-center">
              <h4 class="mt-3 fs-5 mb-1 fw-bold">{{ user.user_name }}</h4>
              <p class="fs-8 mb-2 fw-bold">Votes : {{ user.user_votes }}</p>
              <div class="progress">
                <div
                  class="progress-bar"
                  role="progressbar"
                  :class="getProgressBarColor(calculatePercentage(user.user_votes))"
                  :aria-valuenow="calculatePercentage(user.user_votes)"
                  aria-label="Example with label"
                  :style="{ width: (calculatePercentage(user.user_votes) == 0 ? '10' : calculatePercentage(user.user_votes)) + '%' }"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  {{ calculatePercentage(user.user_votes) }}%
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="copy">
      <div class="container">
        <a href="">2024 &copy; All Rights Reserved | Designed and Developed by Raunak</a>
        <span>
          <a href=""><i class="fab fa-github"></i></a>
          <a href=""><i class="fab fa-google-plus-g"></i></a>
          <a href=""><i class="fab fa-pinterest-p"></i></a>
          <a href=""><i class="fab fa-twitter"></i></a>
          <a href=""><i class="fab fa-facebook-f"></i></a>
        </span>
      </div>
    </div>

    <!-- Modal -->
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-6 fw-bold fs-5" id="exampleModalLabel">
              View Manifesto
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <ul class="molist">
              <li>
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu nibh et
                felis interdum accumsan. Pellentesque elit odio, interdum quis ante in,
                varius rhoncus orci.
              </li>
              <li>
                Etiam laoreet dapibus ante at mollis. Morbi lobortis ultricies risus, in
                faucibus est blandit eu. Nunc nec imperdiet elit.
              </li>
              <li>
                Praesent eget massa finibus, placerat tortor sed, pretium justo. Aenean et
                lectus accumsan, tincidunt metus sit amet, laoreet nunc.
              </li>
              <li>
                In et tincidunt est. Sed neque sapien, ultricies a orci et, fringilla
                egestas nibh. Sed luctus eros et erat suscipit fermentum.
              </li>
              <li>
                Cras blandit orci quis purus placerat tincidunt. Nunc ullamcorper iaculis
                nibh, sed dapibus dui lobortis nec.
              </li>
              <li>
                Sed tristique ante ac rhoncus facilisis. Maecenas hendrerit velit a
                interdum convallis. Vivamus tempus eu justo nec rutrum. Praesent
                sollicitudin interdum nisl, at sollicitudin justo interdum vel
              </li>
              <li>
                Pellentesque habitant morbi tristique senectus et netus et malesuada fames
                ac turpis egestas. Nunc eget orci maximus, tincidunt nulla molestie, porta
                nisi. Integer fringilla lorem at lacinia iaculis.
              </li>
              <li>
                Maecenas tempus libero laoreet est facilisis, vitae iaculis dui eleifend.
                Proin eget magna vitae diam dictum interdum at at nulla. Fusce eu
                porttitor felis. Aenean pretium lacinia nunc ut convallis.
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <LoginModal />
  </section>
</template>

<script>
import TheHeader from "../components/TheHeader.vue";
import LoginModal from "../components/LoginModal.vue";

export default {
  components: {
    TheHeader,
    LoginModal,
  },
  created() {
    this.$store.dispatch("getCompany");

  },
  computed: {
    totalVotes() {
      return this.$store.getters.getCompany.users.reduce(
        (total, user) => total + user.user_votes,
        0
      );
    },
    company() {
      return this.$store.getters.getCompany;
    },
  },
  methods: {
    calculatePercentage(votes) {
      return this.totalVotes ? ((votes / this.totalVotes) * 100).toFixed(0) : 0;
    },
    getProgressBarColor(percentage) {
      if (percentage < 33) {
        return "bg-danger"; // Red for low percentage
      } else if (percentage < 66) {
        return "bg-warning"; // Yellow for medium percentage
      } else {
        return "bg-success"; // Green for high percentage
      }
    },
  },
};
</script>

<style lang="scss" scoped></style>
