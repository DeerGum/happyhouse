<template>
  <b-container class="bv-example-row mt-3" v-if="userInfo">
    <div class="mypage-logo">
      <img src="@/assets/houselogo.png" width="460px" height="200px"/>
    </div>
    <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-jumbotron class="mypage-border">
          <template #header>
            <b-avatar b-avatar size="72px"></b-avatar>
          </template>

          <template #lead>
            <h5 class="mypage-userid">{{ userInfo.userId }}</h5>
            <b-icon icon="pencil-fill" class="icon-modify" @click="moveUserUpdate()"></b-icon>
            <b-icon icon="star-fill" class="icon-bookmark"></b-icon>
          </template>

          <hr class="my-4" />

          <b-container class="mt-4">
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">아이디 : </b-col
              ><b-col cols="4" align-self="start">{{ userInfo.userId }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">이름 : </b-col
              ><b-col cols="4" align-self="start">{{
                userInfo.userName
              }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">이메일 : </b-col
              ><b-col cols="4" align-self="start">{{ userInfo.email }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
            <b-row>
              <b-col cols="2"></b-col>
              <b-col cols="2" align-self="end">가입일 : </b-col
              ><b-col cols="4" align-self="start">{{
                userInfo.joinDate
              }}</b-col>
              <b-col cols="2"></b-col>
            </b-row>
          </b-container>
          <hr class="my-4" />

          <b-button variant="danger" @click="removeUser()">회원탈퇴</b-button>
        </b-jumbotron>
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import { deleteUser } from "@/api/user.js";

const userStore = "userStore";

export default {
  name: "UserMyPage",
  computed: {
    ...mapState(userStore, ["userInfo"]),
  },
  methods: {
    ...mapMutations(userStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    removeUser() {
        deleteUser(JSON.stringify(this.userInfo),
        (response) => {
            alert("삭제가 완료되었습니다.");
            console.log("delete success" + response);
            this.SET_IS_LOGIN(false);
            this.SET_USER_INFO(null);
            sessionStorage.removeItem("access-token");
            this.$router.push({ name: "Home" });
        },
        (error) => {
            alert("삭제 처리시 문제가 발생했습니다.");
            console.log("delete error :" + error);
        });
    },
    
    moveUserUpdate() {
      this.$router.push({ name: 'UserUpdate' });
    }
  }
};
</script>

<style scoped>
  .mypage-logo {
    text-align: center;
  }

  .mypage-border {
    text-align: center;
    padding: 20px;
    border: dashed #8CBDED;
  }

  .mypage-userid {
    color: #8CBDED;
    display: inline;
  }
  .icon-modify {
    color: chocolate;
    margin-left: 5px;
  }
  .icon-bookmark {
    color: #FFDC3C;
    margin-left: 5px;
  }
</style>
