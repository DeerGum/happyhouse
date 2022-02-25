<template>
  <b-container class="bv-example-row mt-3">
    <div class="login-logo">
      <img src="@/assets/houselogo.png" width="460px" height="200px"/>
    </div>
    <b-row></b-row>
    <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-card class="login-form-border text-center mt-3" style="max-width: 40rem" align="left">
          <h3 class="login-login">LOGIN</h3>
          <b-form class="login-form-form">
            <b-form-group label-for="userid">
              <b-form-input
                id="userid"
                v-model="user.userId"
                required
                placeholder="아이디"
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-form-group label-for="userpwd">
              <b-form-input
                type="password"
                id="userpwd"
                v-model="user.userPwd"
                required
                placeholder="비밀번호"
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-button
              type="button"
              variant="primary"
              class="login-button m-1"
              @click="confirm"
              >로그인</b-button
            >
          </b-form>
        </b-card>
      </b-col>
      <b-col></b-col>
    </b-row>
    <b-row class="login-alert">
      <b-col></b-col>
      <b-col><b-alert class="text-center" show variant="danger" v-if="isLoginError">아이디 또는 비밀번호를 확인하세요.</b-alert></b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapActions } from "vuex";

const userStore = "userStore";

export default {
  name: "UserLogin",
  data() {
    return {
      user: {
        userId: null,
        userPwd: null,
      },
    };
  },
  computed: {
    ...mapState(userStore, ["isLogin", "isLoginError", "userInfo"]),
  },
  methods: {
    ...mapActions(userStore, ["userConfirm", "getUserInfo"]),
    async confirm() {
      await this.userConfirm(this.user);
      let token = sessionStorage.getItem("access-token");
      if (this.isLogin) {
        await this.getUserInfo(token);
        this.$router.push({ name: "Home" });
      }
    },
  },
};
</script>

<style scoped>
  .login-logo {
    text-align: center;
  }

  .login-form-border {
    text-align: center;
    margin-left: 30%;
    width: 300px;
    height: 300px;
    padding: 20px;
    border: dashed #8CBDED;
  }

  .login-button {
    background-color: #8CBDED;
    border-color: #8CBDED;
  }

  .login-login {
    color: #8CBDED;
  }

  .login-form-form {
    margin-top: 30px;
  }

  .login-alert {
    margin-top: 30px;
    margin-left: 10px;
  }

</style>
