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
          <form action="" method="post" id="voteForm">
            <div class="form-group mt-3">
              <label for="name">Your legal name</label>
              <input
                required
                type="text"
                class="form-control"
                v-model.trim="companyName"
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
            <input type="submit" id="submit-form" style="display: none" />
          </form>
        </div>
        <div class="modal-footer">
          <!-- cancel button -->
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            Cancel
          </button>
          <label for="submit-form" tabindex="0" class="btn btn-primary" id="submitVote"
            >Submit</label
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    selectedName: String,
  },
  data() {
    return {
      login: false,
      name: "",
      companyName: "",
      phone: "",
      email: "",
      password: "",
    };
  },
  methods: {},
};
</script>

<style lang="scss" scoped></style>
