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
              {{ login ? "Login" : "Register" }}
            </h5>
          </div>
          <div class="d-flex">
            <button type="button" class="btn btn-primary" @click="login = !login">
              {{ login ? "Register" : "Login" }}
            </button>
          </div>
        </div>
        <div class="modal-body" v-if="!login">
          <form action="" method="post" id="voteForm">
            <div class="form-group mt-3">
              <label for="name">Company Name</label>
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
              <label for="phone">Phone</label>
              <input
                required
                type="text"
                v-model="phone"
                class="form-control"
                id="phone"
                pattern="[0-9]{10, 12}"
                onkeypress="return /[0-9]/i.test(event.key) || event.key === 'Backspace'"
                oninvalid="setCustomValidity('Invalid! Enter Correct Phone Number')"
                oninput="setCustomValidity('')"
                placeholder="Enter your Phone number"
                inputmode="numeric"
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
              <label for="password">Password</label>
              <input
                required
                type="password"
                class="form-control"
                id="password"
                v-model="password"
                placeholder="Enter your password"
              />
            </div>
            <input type="submit" id="submit-form" style="display: none" />
          </form>
        </div>
        <div class="modal-body" v-else>
          <form action="" method="post" id="voteForm">
            <div class="form-group mt-3">
              <label for="name">Email</label>
              <input
                required
                type="text"
                pattern="[^@\s]{2,}@[^@\s]{2,}\.[^@\s]{2,}"
                class="form-control"
                v-model.trim="email"
                id="email"
                placeholder="Enter your registered email"
              />
            </div>
            <div class="form-group mt-3">
              <label for="password">Password</label>
              <input
                required
                type="password"
                v-model="password"
                class="form-control"
                id="password"
                placeholder="Enter your password"
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
};
</script>

<style lang="scss" scoped></style>
