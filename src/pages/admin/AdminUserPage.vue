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
              placeholder="Search voters by name"
            />
            <i v-if="search" class="bx bx-search icon" />
            <i v-else class="bx bx-x icon" @click="close" />
          </div>
        </div>
        <div class="in-box">
          <h2 style="text-transform: capitalize">All Voters</h2>
        </div>
        <div class="in-box">
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
      <div class="user" v-for="user in filteredUsers" :key="user.voter_id">
        <div class="dets">
          <div class="name">
            Full Name - <span>{{ user.voter_name }}</span>
          </div>

          <transition name="slide-from-top" appear>
            <div class="hidden" v-if="user.hidden">
              <br />
              <br />
              <div class="name">
                Email - <span>{{ user.voter_email }}</span>
              </div>
              <br />
              <div class="name">
                Voted for - <span>({{ user.voted_for_id }})</span>
                <span>({{ getContestant(user.voted_for_id) }})</span>
              </div>
              <!-- delete bootstap button -->
              <!-- <button
                  class="btn fw-bold fs-8 btn-outline-danger px-5"
                  @click="$store.dispatch('deleteVoter', user.voter_id)"
                >
                  Delete
                </button> -->
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
  </section>
</template>

<script>
export default {
  computed: {
    voters() {
      return this.$store.getters.voters;
    },
    uniquePositions() {
      const positions = this.users.map((user) => user.position);
      return [...new Set(positions)];
    },
    filteredUsers() {
      return this.$store.getters.voters.filter((name) => {
        return name.voter_name.toLowerCase().includes(this.filterText.toLowerCase());
      });
    },
  },
  mounted() {
    this.$store.dispatch("getVoters");
    this.$store.dispatch("getCompany");
  },

  data() {
    return {
      search: true,
      filterText: "",
      name: "",
      email: "",
      position: "",
    };
  },
  methods: {
    filterProducts() {
      this.changeIcon();
    },
    getContestant(id) {
      const company = this.$store.getters.getCompany;
      return company.users.find((user) => user.user_id === id).user_name;
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
