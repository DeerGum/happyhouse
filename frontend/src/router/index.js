import Vue from "vue";
import VueRouter from "vue-router";
import Home from "@/views/Home.vue";

import User from "@/views/User.vue";
import UserLogin from "@/components/user/UserLogin.vue";
import UserJoin from "@/components/user/UserJoin.vue";
import UserMyPage from "@/components/user/UserMyPage.vue";
import UserUpdate from "@/components/user/UserUpdate.vue";
import UserAdminPage from "@/components/user/UserAdminPage.vue";

import Notice from "@/views/Notice.vue";
import NoticeList from "@/components/notice/NoticeList.vue";
import NoticeWrite from "@/components/notice/NoticeWrite.vue";
import NoticeView from "@/components/notice/NoticeView.vue";
import NoticeUpdate from "@/components/notice/NoticeUpdate.vue";

import Question from "@/views/Question.vue"
import QuestionList from "@/components/question/QuestionList.vue";
import QuestionWrite from "@/components/question/QuestionWrite.vue";
import QuestionView from "@/components/question/QuestionView.vue";
import QuestionUpdate from "@/components/question/QuestionUpdate.vue";


import House from "@/views/House.vue";

import store from "@/store/index.js";

Vue.use(VueRouter);

const onlyAuthUser = async (to, from, next) => {
  // console.log(store);
  const checkUserInfo = store.getters["userStore/checkUserInfo"];
  const getUserInfo = store._actions["userStore/getUserInfo"];
  let token = sessionStorage.getItem("access-token");
  if (checkUserInfo == null && token) {
    await getUserInfo(token);
  }
  if (checkUserInfo === null) {
    alert("로그인이 필요한 페이지입니다..");
    // next({ name: "SignIn" });
    router.push({ name: "SignIn" });
  } else {
    console.log("로그인 했다.");
    next();
  }
};

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/user",
    name: "User",
    component: User,
    children: [
      {
        path: "singin",
        name: "SignIn",
        component: UserLogin,
      },
      {
        path: "singup",
        name: "SignUp",
        component: UserJoin,
      },
      {
        path: "mypage",
        name: "MyPage",
        beforeEnter: onlyAuthUser,
        component: UserMyPage,
      },
      {
        path: "userupdate",
        name: "UserUpdate",
        component: UserUpdate,
      },
      {
        path: "useradminpage",
        name: "UserAdminPage",
        component: UserAdminPage,
      },
    ],
  },
  {
    path: "/notice",
    name: "Notice",
    component: Notice,
    redirect: "/notice/list",
    children: [
      {
        path: "list",
        name: "NoticeList",
        component: NoticeList,
      },
      {
        path: "write",
        name: "NoticeWrite",
        beforeEnter: onlyAuthUser,
        component: NoticeWrite,
      },
      {
        path: "detail/:articleno",
        name: "NoticeView",
        component: NoticeView,
      },
      {
        path: "update/:articleno",
        name: "NoticeUpdate",
        component: NoticeUpdate,

      },
    ],
  },
  {
    path: "/question",
    name: "Question",
    component: Question,
    redirect: "/question/list",
    children: [
      {
        path: "list",
        name: "QuestionList",
        component: QuestionList,
      },
      {
        path: "write",
        name: "QuestionWrite",
        beforeEnter: onlyAuthUser,
        component: QuestionWrite,
      },
      {
        path: "detail/:articleno",
        name: "QuestionView",
        component: QuestionView,
      },
      {
        path: "update/:articleno",
        name: "QuestionUpdate",
        component: QuestionUpdate,
      },
    ],
  },
  {
    path: "/house",
    name: "House",
    component: House,
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
