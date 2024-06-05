<template>
  <section>
    <TheHeader :results="true"/> 

    <div class="container py-5 big-padding">
      <div class="row section-title">
        <h2 class="fs-5 text-center">XYZ Company Voting Result</h2>
        <p>
          The below chart shows the voting results of the XYZ company. <br>
          This is just a dummy data and not real. This is just for the demo purpose. <br>
          Please register your own company and make your own voting system.
        </p>
      </div>
      <div class="row mb-5">
        <div class="col-md-6 mb-4">
          <div class="row shado-md p-2 m-0 rounded shadow-md bg-white">
            <div class="col-md-3">
              <img
                class="rounded-pill max-130 p-2"
                src="../assets/images/testimonial/member-01.jpg"
                alt=""
              />
            </div>
            <div class="col-md-9 align-self-center">
              <h4 class="mt-3 fs-5 mb-1 fw-bold">James Anderson</h4>
              <p class="fs-8 mb-2 fw-bold">Votes : 34,567</p>
              <div class="progress">
                <div
                  class="progress-bar bg-danger"
                  role="progressbar"
                  aria-label="Example with label"
                  style="width: 25%"
                  aria-valuenow="25"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  25%
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-6 mb-4">
          <div class="row shado-md p-2 m-0 rounded shadow-md bg-white">
            <div class="col-md-3">
              <img
                class="rounded-pill max-130 p-2"
                src="../assets/images/testimonial/member-02.jpg"
                alt=""
              />
            </div>
            <div class="col-md-9 align-self-center">
              <h4 class="mt-3 fs-5 mb-1 fw-bold">Arun Kumar</h4>
              <p class="fs-8 mb-2 fw-bold">Votes : 34,567</p>
              <div class="progress">
                <div
                  class="progress-bar bg-warning"
                  role="progressbar"
                  aria-label="Example with label"
                  style="width: 55%"
                  aria-valuenow="55"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  55%
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-6 mb-4">
          <div class="row shado-md p-2 m-0 rounded shadow-md bg-white">
            <div class="col-md-3">
              <img
                class="rounded-pill max-130 p-2"
                src="../assets/images/testimonial/member-03.jpg"
                alt=""
              />
            </div>
            <div class="col-md-9 align-self-center">
              <h4 class="mt-3 fs-5 mb-1 fw-bold">Pream Nath</h4>
              <p class="fs-8 mb-2 fw-bold">Votes : 34,567</p>
              <div class="progress">
                <div
                  class="progress-bar bg-primary"
                  role="progressbar"
                  aria-label="Example with label"
                  style="width: 60%"
                  aria-valuenow="60"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  60%
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-6 mb-4">
          <div class="row shado-md p-2 m-0 rounded shadow-md bg-white">
            <div class="col-md-3">
              <img
                class="rounded-pill max-130 p-2"
                src="../assets/images/testimonial/member-04.jpg"
                alt=""
              />
            </div>
            <div class="col-md-9 align-self-center">
              <h4 class="mt-3 fs-5 mb-1 fw-bold">Reena Anath</h4>
              <p class="fs-8 mb-2 fw-bold">Votes : 34,567</p>
              <div class="progress">
                <div
                  class="progress-bar bg-success"
                  role="progressbar"
                  aria-label="Example with label"
                  style="width: 85%"
                  aria-valuenow="85"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  85%
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-6 mb-4">
          <div class="row shado-md p-2 m-0 rounded shadow-md bg-white">
            <div class="col-md-3">
              <img
                class="rounded-pill max-130 p-2"
                src="../assets/images/testimonial/member-05.png"
                alt=""
              />
            </div>
            <div class="col-md-9 align-self-center">
              <h4 class="mt-3 fs-5 mb-1 fw-bold">Allen Shory</h4>
              <p class="fs-8 mb-2 fw-bold">Votes : 34,567</p>
              <div class="progress">
                <div
                  class="progress-bar bg-success"
                  role="progressbar"
                  aria-label="Example with label"
                  style="width: 85%"
                  aria-valuenow="85"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  85%
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-md-6 mb-4">
          <div class="row shado-md p-2 m-0 rounded shadow-md bg-white">
            <div class="col-md-3">
              <img
                class="rounded-pill max-130 p-2"
                src="../assets/images/testimonial/member-06.png"
                alt=""
              />
            </div>
            <div class="col-md-9 align-self-center">
              <h4 class="mt-3 fs-5 mb-1 fw-bold">Aney Kumm</h4>
              <p class="fs-8 mb-2 fw-bold">Votes : 34,567</p>
              <div class="progress">
                <div
                  class="progress-bar bg-success"
                  role="progressbar"
                  aria-label="Example with label"
                  style="width: 85%"
                  aria-valuenow="59"
                  aria-valuemin="0"
                  aria-valuemax="100"
                >
                  59%
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
};
</script>

<style lang="scss" scoped></style>
