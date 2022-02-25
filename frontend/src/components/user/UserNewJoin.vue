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
          <h3 class="login-login">JOIN</h3>
          <b-form @submit="onSubmit" class="login-form-form">
            <b-form-group label="NAME" label-for="userName" class="join-label">
              <b-form-input
                id="userName"
                v-model="user.userName"
                :state="validation"
                required
                placeholder="이름을 입력하세요.."
                @keyup.enter="confirm">
                <b-form-invalid-feedback :state="validation">
                  Your user ID must be 5-12 characters long.
                </b-form-invalid-feedback>
                <b-form-valid-feedback :state="validation">
                  Looks Good.
                </b-form-valid-feedback>
              </b-form-input>
            </b-form-group>
            <b-form-group label="ID" label-for="userid" class="join-label">
              <b-form-input
                id="userId"
                v-model="user.userId"
                required
                placeholder="아이디를 입력하세요.."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-form-group label="PASSWORD" label-for="userpwd" class="join-label">
              <b-form-input
                type="password"
                id="userPwd"
                v-model="user.userPwd"
                required
                placeholder="비밀번호를 입력하세요.."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-form-group label="E-MAIL" label-for="email" class="join-label">
              <b-form-input
                type="email"
                id="email"
                v-model="user.email"
                required
                placeholder="이메일을 입력하세요.."
                @keyup.enter="confirm"
              ></b-form-input>
            </b-form-group>
            <b-button
              type="submit"
              variant="primary"
              class="login-button m-1"
              @click="registJoin()"
              >회원가입</b-button
            >
          </b-form>
        </b-card>
      </b-col>
      <b-col></b-col>
    </b-row>
    <b-row class="login-alert">
      <b-col></b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { registerUser } from "@/api/user.js";

export default {
  name: "UserJoin",
  data() {
    return {
      user: {
        userName: "",
        userId: "",
        userPwd: "",
        email: "",
      },
    };
  },
  computed: {
    validation() {
      return this.userId.length > 4 && this.userId.length < 13
    }
  },
  methods: {

    onSubmit(event) {
      event.preventDefault();

      let err = true;
      let msg = "";
      !this.user.userName &&
        ((msg = "이름을 입력해주세요"),
        (err = false),
        this.$refs.userName.focus());
      err &&
        !this.user.userId &&
        ((msg = "아이디를 입력해주세요"),
        (err = false),
        this.$refs.userId.focus());
      err &&
        !this.user.userPwd &&
        ((msg = "비밀번호를 입력해주세요"),
        (err = false),
        this.$refs.userPwd.focus());
      err &&
        !this.user.email &&
        ((msg = "이메일을 입력해주세요."),
        (err = false),
        this.$refs.email.focus());

      if (!err) alert(msg);
    },

    registJoin() {
      registerUser(
        this.user,
        (response) => {
          alert('회원가입이 완료되었습니다.');
          console.log('registerUser success' + response);
          this.$router.push({ name: 'SignIn' });
        },
        (error) => {
          alert('회원가입시 문제가 발생했습니다.');
          console.log('registerUser error :' + error);
        }
      );
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
    width: 350px;
    height: 550px;
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

  .join-label {
    color:#6495ED;
  }

</style>
