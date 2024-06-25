<template>
  <div
    class="modal fade"
    id="exampleModal2"
    tabindex="-1"
    role="dialog"
    aria-labelledby="exampleModalLabel2"
    aria-hidden="true"
  >
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <!-- flex 2 buttons in header - login and register -->
        <div class="modal-header flex justify-content-between">
          <div class="d-flex">
            <h5 class="modal-title" id="exampleModalLabel2">
              Vote for your favorite member ({{ selectedName }})
            </h5>
          </div>
        </div>
        <div class="modal-body">
          <form action="" method="post" id="voteForm" @submit.prevent="submitVote">
            <div class="form-group mt-3">
              <label for="name">Your legal name</label>
              <input
                required
                type="text"
                class="form-control"
                v-model.trim="name"
                pattern=".{2,}"
                id="name"
                placeholder="Enter your company name"
                oninvalid="setCustomValidity('Enter Valid Company Name!')"
                oninput="setCustomValidity('')"
              />
            </div>
            <div class="form-group mt-3">
              <label for="email">Email</label>
              <input
                required
                type="text"
                pattern="[^@\s]{2,}@[^@\s]{2,}\.[^@\s]{2,}"
                oninvalid="setCustomValidity('Enter Correct Email')"
                oninput="setCustomValidity('')"
                v-model.trim="email"
                class="form-control"
                id="email"
                placeholder="Enter your Email"
              />
            </div>
            <div class="form-group mt-3">
              <label for="name">Your 10 Digit Voting ID</label>
              <input
                required
                type="text"
                class="form-control"
                pattern="[0-9]{10}"
                v-model.trim="vid"
                maxlength="10"
                inputmode="numeric"
                id="vid"
                placeholder="Enter your Voter ID"
                oninvalid="setCustomValidity('Enter Valid ID!')"
                oninput="setCustomValidity('')"
              />
            </div>
            <input type="submit" id="submit-form" style="display: none" />
          </form>
        </div>
        <div class="modal-footer">
          <!-- cancel button -->
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            Cancel
          </button>
          <label
            for="submit-form"
            tabindex="0"
            class="btn btn-primary"
            data-bs-dismiss="modal"
            id="submitVote"
            >Submit</label
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  emits: ["close"],
  props: {
    selectedName: String,
    selectedId: String,
  },
  data() {
    return {
      login: false,
      name: "",
      vid: "",
      email: "",
    };
  },
  methods: {
    async submitVote() {
      await this.$store.dispatch("vote", {
        voter_id: this.vid,
        voted_for_id: this.selectedId,
        voter_name: this.name,
        voter_email: this.email,
      });
      this.$emit("close");
    },
  },
};
</script>

<style lang="scss" scoped></style>
