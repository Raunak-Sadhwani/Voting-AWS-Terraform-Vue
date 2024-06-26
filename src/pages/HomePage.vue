<template>
  <section>
    <TheHeader />

    <div class="container-xl big-padding">
      <div class="row section-title">
        <h2 class="fs-4">{{ company.name }}</h2>
        <p>
          {{ company.description }}
        </p>
      </div>
      <div class="row">
        <div
          class="col-lg-4 col-md-6"
          v-for="user in company.users"
          :key="company.company_id"
        >
          <div class="text-white text-center mb-4 votcard shadow-md bg-white p-4 pt-5">
            <img class="rounded-pill shadow-md p-2" :src="user.user_image" alt="" />
            <h4 class="mt-3 fs-5 mb-1 fw-bold">{{ user.user_name }}</h4>
            <h6 class="fs-7">
              Running to Be:
              <span class="text-primary fw-bold">{{ company.voting_role }}</span>
            </h6>
            <p class="text-dark mt-3 mb-3 fs-8">
              <!-- {{ user.user_descriptions }} -->
            </p>
            <button
              data-bs-toggle="modal"
              data-bs-target="#exampleModal"
              class="btn btn-primary fw-bolder fs-8"
              @click="manifestoButton(user.user_id)"
            >
              View Manifesto
            </button>
            <button
              @click="voteButton(user.user_id)"
              :data-bs-toggle="alreadyVote ? '' : 'modal'"
              data-bs-target="#exampleModal2"
              class="btn btn-danger fw-bolder px-4 ms-2 fs-8"
            >
              Vote
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="container-xl big-padding" id="about">
      <div class="row section-title">
        <h2 class="fs-4">About Us</h2>
        <p>
          In today's fast-paced corporate world, fostering employee engagement and
          ensuring every voice is heard are essential components of a thriving workplace.
          Recognizing this need, we developed a voting website tailored specifically for
          businesses. Our platform allows companies to effortlessly register, add their
          staff members, and generate unique URLs for each employee. This streamlined
          process empowers employees to participate in company-wide decisions, vote for
          their peers, and contribute to a more inclusive and democratic organizational
          culture. Whether it's for internal awards, decision-making, or feedback
          collection, our voting website simplifies the process, making every vote count.
        </p>
      </div>
      <div class="row">
        <div class="col-lg-6 col-md-6">
          <div class="text-white text-center mb-4 votcard shadow-md bg-white p-4 pt-5">
            <img
              class="rounded-pill shadow-md p-2"
              src="../assets/images/Raunak.jpeg"
              alt=""
            />
            <a href="https://raunak.me"
              ><h4 class="mt-3 fs-5 mb-1 fw-bold">Raunak Sadhwani</h4></a
            >
            <h6 class="fs-7">
              Role: <span class="text-danger fw-bold">FullStack & UI/UX Developer</span>
            </h6>
            <p class="text-dark mt-3 mb-3 fs-8">
              I am a Master's student in Software Engineering with two years of full-stack
              development experience. Currently, I am focused on advancing my knowledge
              and contributing to innovative projects in the field of software
              engineering.
            </p>
          </div>
        </div>

        <div class="col-lg-6 col-md-6">
          <div class="text-white text-center mb-4 votcard shadow-md bg-white p-4 pt-5">
            <img
              class="rounded-pill shadow-md p-2"
              src="../assets/images/aditya.jpg"
              alt=""
            />
            <h4 class="mt-3 fs-5 mb-1 fw-bold">Aditya Gawade</h4>
            <h6 class="fs-7">
              Role: <span class="text-danger fw-bold">Backend Developer</span>
            </h6>
            <p class="text-dark mt-3 mb-3 fs-8">
              I have five years of professional experience. I am constantly learning and
              staying updated with the latest industry trends. My goal is to make a
              significant impact in the field of software engineering and drive positive
              change through my work.
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="copy">
      <div class="container">
        <a href="https://raunak.me"
          >2024 &copy; All Rights Reserved | Designed and Developed by <u>Raunak</u></a
        >
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
              <li v-for="line in manifesto.split('\n')" :key="line">{{ line }}</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <LoginModal
      :selected-id="selectedId"
      :selected-name="selectedName"
      @close="showDialog = true"
    />
    <BaseDialog
      :show="showDialog"
      :title="alreadyVote ? 'Already Voted' : 'Thank you for voting'"
      @close="showDialog = false"
    >
      <p v-if="!alreadyVote">
        Thank you for voting for {{ selectedName }}. Your vote has been recorded.
      </p>
      <p v-else>
        You have already voted. If you would like to change your vote, please contact the
        administrator.
      </p>
    </BaseDialog>
  </section>
</template>

<script>
import TheHeader from "../components/TheHeader.vue";
import LoginModal from "../components/LoginModal.vue";
import BaseDialog from "../components/BaseDialog.vue";
export default {
  components: {
    TheHeader,
    LoginModal,
    BaseDialog,
  },
  data() {
    return {
      selectedName: "",
      selectedId: "",
      name: "",
      manifesto: "",
      showDialog: false,
      alreadyVote: false,
    };
  },
  computed: {
    company() {
      return this.$store.getters.getCompany;
    },
    host() {
      return this.$store.getters.host;
    },
  },
  created() {
    this.$store.dispatch("getCompany");
    const voted = localStorage.getItem("voted");
    if (voted) {
      this.alreadyVote = true;
    }
  },
  methods: {
    voteButton(id) {
      if (this.alreadyVote) {
        this.showDialog = true;
        return;
      }
      this.selectedId = id;
      this.selectedName = this.company.users.find(
        (user) => user.user_id === id
      ).user_name;
    },
    manifestoButton(id) {
      this.manifesto = this.company.users.find(
        (user) => user.user_id === id
      ).user_manifesto;
    },
  },
};
</script>

<style lang="scss" scoped></style>
