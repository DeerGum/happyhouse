<template>
  <b-container class="bv-example-row mt-3">
    <div class="login-logo">
      <img src="@/assets/houselogo.png" width="460px" height="200px" />
    </div>
    <b-row></b-row>
    <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-card class="login-form-border text-center mt-3" style="max-width: 40rem" align="left">
          <h3 class="login-login">JOIN</h3>
          <b-form @submit="onSubmit" class="login-form-form">
            <b-form-group label="이름" label-for="userName" class="join-label">
              <b-form-input
                id="userName"
                v-model="user.userName"
                required
                placeholder="이름"
              ></b-form-input>
            </b-form-group>
            <b-form-group label="아이디" label-for="userid" class="join-label">
              <b-form-input
                id="userId"
                v-model="user.userId"
                :state="idValid"
                required
                placeholder="아이디"
                aria-describedby="inputId"
                @keyup="idCheck"
              ></b-form-input>
              <b-form-invalid-feedback id="inputId"
                >6글자 미만이거나 중복된 아이디가 있습니다.</b-form-invalid-feedback
              >
            </b-form-group>
            <b-form-group label="비밀번호" label-for="userpwd" class="join-label">
              <b-form-input
                type="password"
                id="userPwd"
                v-model="user.userPwd"
                :state="pwdValid"
                required
                placeholder="비밀번호 (4글자 이상)"
                aria-describedby="inputPwd"
                @keyup="pwdCheck"
              ></b-form-input>
              <b-form-invalid-feedback id="inputPwd"
                >4글자 이상 입력해주세요.</b-form-invalid-feedback
              >
            </b-form-group>
            <b-form-group label="비밀번호 확인" label-for="confirmpwd" class="join-label">
              <b-form-input
                type="password"
                id="confirmPwd"
                v-model="confirmPwd"
                :state="confirmPwdValid"
                required
                placeholder="비밀번호 확인"
                aria-describedby="inputConfirmPwd"
                @keyup="confirmPwdCheck"
              ></b-form-input>
              <b-form-invalid-feedback id="inputConfirmPwd"
                >비밀번호가 다릅니다.</b-form-invalid-feedback
              >
            </b-form-group>
            <b-form-group label="E-MAIL" label-for="email" class="join-label">
              <b-form-input
                type="email"
                id="email"
                v-model="user.email"
                required
                placeholder="이메일을 입력하세요.."
              ></b-form-input>
            </b-form-group>
            <b-button type="submit" variant="primary" class="login-button m-1">회원가입</b-button>
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
import { registerUser, checkId } from '@/api/user.js';

export default {
  name: 'UserJoin',
  data() {
    return {
      user: {
        userName: '',
        userId: '',
        userPwd: '',
        email: '',
      },
      idValid: null,
      pwdValid: null,
      confirmPwd: '',
      confirmPwdValid: null,
    };
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();

      let msg = '[';
      let err = false;

      if (!this.idValid) {
        msg += ' 아이디 ';
        err = true;
      }
      if (!this.pwdValid) {
        msg += ' 비밀번호 ';
        err = true;
      }
      if (!this.confirmPwdValid) {
        msg += ' 비밀번호 확인 ';
        err = true;
      }
      msg += ']에 문제가 있습니다.';

      if (err) alert(msg);
      else this.registJoin();
    },
    idCheck() {
      if (this.user.userId.length > 4) {
        checkId(
          this.user.userId,
          ({ data }) => {
            if (data === 'success') {
              this.idValid = true;
            } else {
              this.idValid = false;
            }
          },
          (error) => {
            console.log('아이디 검사 에러 : ' + error);
          }
        );
      } else if (this.user.userId.length > 0) {
        this.idValid = false;
      } else {
        this.idValid = null;
      }
    },
    pwdCheck() {
      if (this.user.userPwd.length > 3) {
        this.pwdValid = true;
      } else if (this.user.userPwd.length > 0) {
        this.pwdValid = false;
      } else {
        this.pwdValid = null;
      }
    },
    confirmPwdCheck() {
      if (this.user.userPwd.length == 0) {
        this.confirmPwdValid = null;
      } else if (this.confirmPwd == this.user.userPwd) {
        this.confirmPwdValid = true;
      } else {
        this.confirmPwdValid = false;
      }
    },
    registJoin() {
      registerUser(
        this.user,
        ({ data }) => {
          let msg = '';
          if (data === 'success') msg = '회원가입이 완료되었습니다.';
          else msg = '회원가입시 문제가 발생했습니다.';
          alert(msg);
          this.$router.push({ name: 'SignIn' });
        },
        (error) => {
          alert('회원가입시 서버문제가 발생했습니다.');
          console.log('회원가입 에러 : ' + error);
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
  margin-left: 190px;
  width: 350px;
  height: 650px;
  padding: 20px;
  border: dashed #8cbded;
}

.login-button {
  background-color: #8cbded;
  border-color: #8cbded;
}

.login-login {
  color: #8cbded;
}

.login-form-form {
  margin-top: 30px;
}

.login-alert {
  margin-top: 30px;
  margin-left: 10px;
}

.join-label {
  color: #6495ed;
}
</style>
