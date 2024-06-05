<template>
  <section class="manageMain">
    <div class="flex-end">
      <div class="flex-box">
        <div class="in-box">
          <div class="search" style="text-transform: capitalise; width: 85%">
            <input
              type="text"
              v-model="filterText"
              @keyup="filterProducts"
              @focusin="changeIcon"
              @focusout="changeIcon"
              style="text-transform: capitalise; width: 90%"
              placeholder="Search staff member by name"
            />
            <i v-if="search" class="bx bx-search icon" />
            <i v-else class="bx bx-x icon" @click="close" />
          </div>
        </div>
        <div class="in-box">
          <h2 style="text-transform: capitalize">All Staff Members</h2>
        </div>
        <div class="in-box">
          <button data-bs-toggle="modal" data-bs-target="#addStaff" class="button-42">
            View Manifesto
          </button>
          <!-- <button
            class="button-42"
            @click="showFilters = !showFilters"
            style="text-transform: uppercase; padding: 0.5rem 1.5rem"
          >
            Add Staff Member
          </button> -->
        </div>
      </div>
    </div>
    <!-- <div class="productList"></div> -->
    <div class="userlist">
      <div class="user" v-for="user in filteredUsers" :key="user.id">
        <div class="dets">
          <div class="name">
            Full Name - <span>{{ user.name }}</span>
          </div>

          <transition name="slide-from-top" appear>
            <div class="hidden" v-if="user.hidden">
              <br />
              <div class="name">
                Position - <span>{{ user.position }}</span>
              </div>
              <br />
              <div class="name">
                Email - <span>{{ user.email }}</span>
              </div>
              <br />
              <div class="name">
                Website Link -
                <a style="font-size: 1rem" :href="user.url">{{ user.url }}</a>
              </div>
            </div>
          </transition>
        </div>
        &nbsp;
        <div class="man">
          <div>
            <button class="button-42" @click="user.hidden = !user.hidden">
              <i
                class="bx"
                :class="{ 'bx-chevron-down': !user.hidden, 'bx-chevron-up': user.hidden }"
              />
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- <transition name="slide-from-left" appear>
      <div class="filters side-bar" v-if="showFilters">
        <i class="bx bx-x icon" @click="showFilters = !showFilters" />
        <h1 class="heading">Filters</h1>
        <div class="box">
          <h3 class="title">Sort by :</h3>
          <div class="category">
            <div
              v-for="(tab, index) in tabs"
              :key="index"
              class="btn"
              :class="{ active: activeTab === tab.value }"
              @click="changeTab(tab.value)"
            >
              {{ tab.label }}
            </div>
          </div>
        </div>
        <div class="box">
          <h3 class="title">Sort by Date :</h3>
          <div class="type">
            <label for="from_date">From Date</label> <br />
            <input type="date" v-model="fromDate" />
            <br /><br />
            <label for="from_date">To Date</label> <br />
            <input type="date" v-model="toDate" />
          </div>
        </div>
        <div class="reset-btn">
          <div class="btn">reset all</div>
        </div>
      </div>
    </transition> -->
    <!-- <div class="backdrop" @click="showFilters = !showFilters" v-if="showFilters" /> -->

    <div
      class="modal fade"
      id="addStaff"
      tabindex="-1"
      aria-labelledby="addStaffLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-6 fw-bold fs-5" id="addStaffLabel">
              Add Staff Member
            </h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <form action="" method="post" @submit.prevent="addStaff" id="voteForm">
              <div class="form-group mt-3">
                <label for="name">Full Name</label>
                <input
                  required
                  type="text"
                  class="form-control"
                  id="name"
                  placeholder="Enter staff Full name"
                  v-model.trim="name"
                  maxlength="60"
                  name="name"
                  oninvalid="setCustomValidity('Invalid! Enter Full Name')"
                  onkeydown="return /[a-z ]/i.test(event.key)"
                  oninput="setCustomValidity('')"
                  title="Enter Full Name"
                  pattern="^((\b[a-zA-Z]{2,40}\b)\s*){2,3}$"
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
                  class="form-control"
                  v-model.trim="email"
                  id="email"
                  placeholder="Enter your email"
                />
              </div>
              <div class="form-group mt-3">
                <label for="position">Position</label>
                <input
                  required
                  type="text"
                  list="positions"
                  class="form-control"
                  v-model.trim="position"
                  id="position"
                  placeholder="Enter your position"
                  oninvalid="setCustomValidity('Enter Valid Position!')"
                  oninput="setCustomValidity('')"
                />
                <datalist id="positions">
                  <option
                    v-for="position in uniquePositions"
                    :key="position"
                    :value="position"
                  ></option>
                </datalist>
              </div>
              <input type="submit" id="submit-form" style="display: none" />
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              Close
            </button>
            <label for="submit-form" tabindex="0" class="btn btn-primary" id="submitVote"
              >Add Staff</label
            >
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["token", "authMessage", "host", "authError", "newUrl"]),
    uniquePositions() {
      const positions = this.users.map((user) => user.position);
      return [...new Set(positions)];
    },
    filteredUsers() {
      return this.users.filter((name) => {
        // Check if the name matches the search query
        let nameMatches = name.name.toLowerCase().includes(this.filterText.toLowerCase());
        return nameMatches;
      });
    },
  },
  mounted() {},

  data() {
    return {
      search: true,
      filterText: "",
      name: "",
      email: "",
      position: "",
      users: [
        {
          id: 1,
          name: "John Doe",
          email: "john@doe.com",
          position: "Manager",
          hidden: false,
          url: "https://www.vx.web.app/john2898239",
        },
        {
          id: 2,
          name: "Jane Schmoe",
          email: "jane@Schmoe.com",
          position: "Assistant Manager",
          hidden: false,
          url: "https://www.vx.web.app/jane2898239",
        },
        {
          id: 3,
          name: "Alice Peterson",
          email: "alice@pet.com",
          position: "Secretary",
          hidden: false,
          url: "https://www.vx.web.app/alice2898239",
        },
        // generate more 10 users, random names, emails, positions, urls
        {
          id: 4,
          name: "Sarah Johnson",
          email: "sarah@johnson.com",
          position: "Designer",
          hidden: false,
          url: "https://www.vx.web.app/sarah2898239",
        },
        {
          id: 5,
          name: "Michael Smith",
          email: "michael@smith.com",
          position: "Developer",
          hidden: false,
          url: "https://www.vx.web.app/michael2898239",
        },
        {
          id: 6,
          name: "Emily Davis",
          email: "emily@davis.com",
          position: "Marketing Manager",
          hidden: false,
          url: "https://www.vx.web.app/emily2898239",
        },
        {
          id: 7,
          name: "David Wilson",
          email: "david@wilson.com",
          position: "Sales Representative",
          hidden: false,
          url: "https://www.vx.web.app/david2898239",
        },
        {
          id: 8,
          name: "Olivia Thompson",
          email: "olivia@thompson.com",
          position: "HR Manager",
          hidden: false,
          url: "https://www.vx.web.app/olivia2898239",
        },
        {
          id: 9,
          name: "James Anderson",
          email: "james@anderson.com",
          position: "Accountant",
          hidden: false,
          url: "https://www.vx.web.app/james2898239",
        },
        {
          id: 10,
          name: "Sophia Martinez",
          email: "sophia@martinez.com",
          position: "Customer Support",
          hidden: false,
          url: "https://www.vx.web.app/sophia2898239",
        },
        {
          id: 11,
          name: "Daniel Clark",
          email: "daniel@clark.com",
          position: "Project Manager",
          hidden: false,
          url: "https://www.vx.web.app/daniel2898239",
        },
        {
          id: 12,
          name: "Ava Rodriguez",
          email: "ava@rodriguez.com",
          position: "Quality Assurance",
          hidden: false,
          url: "https://www.vx.web.app/ava2898239",
        },
        {
          id: 13,
          name: "William Lee",
          email: "william@lee.com",
          position: "Data Analyst",
          hidden: false,
          url: "https://www.vx.web.app/william2898239",
        },
      ],
    };
  },
  methods: {
    filterProducts() {
      this.changeIcon();
    },
    changeIcon() {
      if (this.filterText.length > 0) {
        this.search = false;
      } else {
        this.search = true;
      }
    },
    close() {
      this.search = true;
      this.filter = "";
    },
    addStaff() {
      // Add staff member
      const staff = {
        name: this.name,
        email: this.email,
        position: this.position,
      };
      this.users.unshift(staff);
      this.name = "";
      this.email = "";
      this.position = "";
      //   dissmiss modal
      $("#addStaff").modal("hide");
    },
  },
};
</script>

<style scoped>
.slide-from-left-enter-active,
.slide-from-top-enter-active,
.slide-from-left-leave-active,
.slide-from-top-leave-active {
  transition: all 0.2s ease-in-out;
}
.slide-from-left-enter-from,
.slide-from-left-leave-to {
  transform: translateX(100%);
}

.slide-from-left-enter-to,
.slide-from-left-leave-from {
  transform: translateX(0);
}

.slide-from-top-enter-from,
.slide-from-top-leave-to {
  transform: translateY(-10px);
}

.slide-from-top-enter-to,
.slide-from-top-leave-from {
  transform: translateY(0);
}

input[type="date"] {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 5px;
  outline: none;
  font-size: 0.9rem;
  margin-top: 0.5rem;
}
::-webkit-scrollbar {
  width: 10px;
}

::-webkit-scrollbar-track {
  background-color: transparent;
}

::-webkit-scrollbar-thumb {
  background-color: var(--black);
}
.manageMain {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  width: 100%;
  padding: 4% 0%;
}
.icon {
  cursor: pointer;
}

input {
  background-color: white;
  border: none;
  outline: 0;
  width: 85%;
}

.flex-end {
  display: flex;
  flex-direction: row;
  justify-content: center;
  width: 100%;
}

.search {
  width: 90%;
  padding: 1rem;
  background-color: white;
}

i {
  font-size: 1.1rem;
  height: 100%;
}

.flex-box {
  display: flex;
  justify-content: space-between;
  width: 100%;
  padding: 0 7%;
  height: 100%;
}

.in-box {
  width: 33%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.userlist {
  width: 100%;
  display: flex;
  flex-direction: column;
  /* align-items: flex-end; */
  padding-left: 9%;
  margin-top: 2rem;
}

button {
  padding: 0.3rem 0.5rem;
}
button i {
  font-size: 1.5rem;
  line-height: 1.7rem;
}

.user {
  display: flex;
  justify-content: space-between;
  width: 86%;
  background-color: whitesmoke;
  padding: 1.5%;
  margin-top: calc(1.5rem + 1.5%);
  margin-bottom: 5vh;
  position: relative;
  box-shadow: 4px 4px 10px 5px rgba(0, 0, 0, 0.15);
}

.man {
  display: flex;
  justify-content: space-around;
  width: 15%;
}
.dets {
  display: flex;
  flex-direction: column;
  padding-top: 0.5rem;
  width: 40%;
}
.reg {
  position: absolute;
  top: -2.6rem;
  right: 0;
  padding: 0.5rem 1rem;
  width: max-content;
  background-color: whitesmoke;
  border-top-right-radius: 6px;
  border-top-left-radius: 6px;
  border-bottom: 1px solid #cccccc19;
}
.name {
  font-size: 1.2rem;
  font-weight: 500;
  text-transform: capitalize;
}
.name span {
  font-weight: 400;
  text-transform: capitalize;
}

.heading {
  margin-bottom: 20px;
  font-size: 30px;
  color: var(--black);
  text-transform: uppercase;
  text-align: center;
}

.btn {
  margin-top: 10px;
  display: inline-block;
  padding: 10px 30px;
  cursor: pointer;
  font-size: 17px;
  background-color: var(--light-bg);
  color: var(--black);
  text-transform: capitalize;
  text-align: center;
}

.btn:hover {
  background-color: var(--crimson);
  color: var(--white);
}

.side-bar::-webkit-scrollbar {
  width: 5px;
}

.side-bar .box {
  border-bottom: var(--border);
  padding: 20px 0;
}

.side-bar .box .title {
  margin-bottom: 10px;
  color: var(--black);
  font-size: 20px;
  text-transform: uppercase;
}

.side-bar .btn {
  margin-left: 5px;
}

.side-bar .btn.active {
  background-color: var(--crimson);
  color: var(--white);
}

.side-bar .box #search-box {
  border: var(--border);
  padding: 12px;
  text-transform: none;
  color: var(--light-black);
  width: 100%;
  font-size: 17px;
}

.side-bar .reset-btn .btn {
  margin-top: 20px;
  width: 100%;
}
.backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 9;
  backdrop-filter: blur(3px);
  opacity: 1;
  pointer-events: auto;
  transition: opacity 0.3s ease-in-out;
}

.filters {
  position: relative;
  transition: all 0.2s linear;
  font-family: "Poppins", sans-serif;
  width: 20%;
  height: 100%;
  background-color: white;
  position: fixed;
  top: 0;
  right: 0;
  z-index: 10;
  padding: 20px;
  border-right: 1px solid #999;
  overflow-y: auto;
}
.side-bar .box {
  border-bottom: 1px solid #999;
  padding: 20px 0;
}

.side-bar .box .title {
  margin-bottom: 10px;
  color: black;
  font-size: 20px;
  text-transform: uppercase;
}

.side-bar .btn {
  margin-left: 5px;
}

.side-bar .btn.active {
  background-color: crimson;
  color: white;
}

.side-bar .box #search-box {
  border: 1px solid #999;
  padding: 12px;
  text-transform: none;
  color: #666;
  width: 100%;
  font-size: 17px;
}

.side-bar .reset-btn .btn {
  margin-top: 20px;
  width: 100%;
}
.filters i {
  position: absolute;
  height: max-content;
  padding: 0.8rem 0;
}

.filters::-webkit-scrollbar {
  width: 5px;
}
.button-42 {
  background-color: initial;
  background-image: linear-gradient(-180deg, #ff7e31, #e62c03);
  border-radius: 6px;
  box-shadow: rgba(0, 0, 0, 0.1) 0 2px 4px;
  color: whitesmoke;
  cursor: pointer;
  display: inline-block;
  outline: 0;
  pointer-events: auto;
  position: relative;
  text-align: center;
  touch-action: manipulation;
  user-select: none;
  -webkit-user-select: none;
  vertical-align: top;
  white-space: nowrap;
  z-index: 1;
  border: 0;
  font-weight: 500;
  transition: box-shadow 0.2s;
}

.button-42:hover {
  box-shadow: rgba(253, 76, 0, 0.5) 0 3px 8px;
}
</style>
