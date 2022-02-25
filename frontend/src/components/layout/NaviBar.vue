<template>
  <b-container>
    <b-navbar>
      <b-navbar-brand href="#">
          <router-link to="/" class="logo">
            <img src="@/assets/logo.png" width="80px"/>
          </router-link>
        </b-navbar-brand>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item href="#" 
            ><router-link :to="{ name: 'Home' }" class="text-primary"
            >HOME</router-link
            ></b-nav-item
          >
          <!--<b-nav-item href="#"
            ><router-link :to="{ name: 'GuestBook' }" class="link"
            >COMMUNITY</router-link
            ></b-nav-item
          >-->
          <b-nav-item-dropdown
            id="my-nav-dropdown"
            text="COMMUNITY"
            toggle-class="text-primary"
            right
          >
            <b-dropdown-item
              ><router-link :to="{ name: 'Notice' }" class="text-primary"
              >공지사항</router-link
              ></b-dropdown-item
            >
            <b-dropdown-item href="#"
              ><router-link :to="{ name: 'Question' }" class="text-primary"
              >QnA</router-link
              ></b-dropdown-item
            >
          </b-nav-item-dropdown>

          <b-nav-item href="#"
            ><router-link :to="{ name: 'House' }" class="text-primary"
            >APARTMENTS</router-link
            ></b-nav-item
          >
        </b-navbar-nav>

        <b-navbar-nav class="ml-auto" v-if="userInfo">
          <b-nav-item class="align-self-center">
            <b-avatar variant="primary" size="sm" class="login-avatar"></b-avatar>
            {{ userInfo.userId }}님환영합니다.
          </b-nav-item>
          
          <b-button-group>
            <b-button variant="success" @click="moveAdminPage()" class="user-mypage" size="sm" v-if="userInfo.userId === 'admin'">회원관리</b-button>
            <b-button variant="primary" @click="moveMyPage()" class="user-mypage" size="sm">MyPage</b-button>
            <b-button variant="danger" @click="onClickLogout()" class="user-logout" size="sm">Logout</b-button>
          </b-button-group>
        </b-navbar-nav>

        <b-navbar-nav class="ml-auto" v-else>
          <b-button-group>
            <b-button variant="primary" @click="moveLogin()" class="user" size="sm">로그인</b-button>
            <b-button variant="primary" @click="moveJoin()" class="user" size="sm">회원가입</b-button>
          </b-button-group>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </b-container>
</template>

<script>
import { mapState, mapMutations } from "vuex";

const userStore = "userStore";

export default {
  name: "NaviBar",
  computed: {
    ...mapState(userStore, ["isLogin", "userInfo"]),
  },
  methods: {
    ...mapMutations(userStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    onClickLogout() {
      this.SET_IS_LOGIN(false);
      this.SET_USER_INFO(null);
      sessionStorage.removeItem("access-token");
      if (this.$route.path != "/") this.$router.push({ name: "Home" });
    },
    moveLogin() {
      this.$router.push({ name: 'SignIn' });
    },
    moveJoin() {
      this.$router.push({ name: 'SignUp' });
    },
    moveMyPage() {
      this.$router.push({ name: 'MyPage' });
    },
    moveAdminPage() {
      this.$router.push({ name: 'UserAdminPage' });
    },
  }
};
</script>

<style scoped>

  .user {
    background-color: #8CBDED;
    border-color: #8CBDED;
    margin: 5px;
  }

  .user-mypage {
    background-color: #8CBDED;
    border-color: #8CBDED;
    height: 30px;
    text-align: center;
    margin: 5px;
  }

  .user-logout {
    background-color: #FF9696;
    border-color: #FF9696;
    height: 30px;
    text-align: center;
    margin: 5px;
  }

  .login-avatar {
    background-color: #8CBDED;
    border-color: #8CBDED;
    margin: 5px;
  }

  .link {
    color:#8CBDED;
    margin-left: 15px;
  }

  .navbar {
    background-color: white;
  }

</style>
