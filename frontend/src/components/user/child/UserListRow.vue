<template>
  <tbody>
    <b-tr v-if="!modifyMode">
      <b-td>{{ userInfo.userId }}</b-td>
      <b-td>{{ userInfo.userName }}</b-td>
      <b-td>{{ userInfo.email }}</b-td>
      <b-td>
        <b-button variant="outline-info" size="sm" class="mr-2" @click="toggleModify()"
          >수정</b-button
        >
        <b-button
          variant="outline-danger"
          size="sm"
          @click="remove()"
          v-if="this.userId != 'admin'"
          >삭제</b-button
        >
      </b-td>
    </b-tr>
    <b-tr v-if="modifyMode">
      <!-- 수정 모드 -->
      <b-td>
        <b-form-input id="text" v-model="userInfo.userId" readonly></b-form-input>
      </b-td>
      <b-td>
        <b-form-input id="text" v-model="userInfo.userName"></b-form-input>
      </b-td>
      <b-td>
        <b-form-input id="email" v-model="userInfo.email"> </b-form-input>
      </b-td>
      <b-td>
        <b-button variant="outline-info" size="sm" class="mr-2" @click="modify()"
          >수정</b-button
        >
        <b-button variant="outline-danger" size="sm" @click="toggleModify()">취소</b-button>
      </b-td>
    </b-tr>
  </tbody>
</template>

<script>
import { modifyUser, deleteUser } from '@/api/user.js';

export default {
  name: 'UserListRow',
  props: {
    userId: String,
    userName: String,
    email: String,
    userPwd: String,
  },
  data() {
    return {
      userInfo: {
        userId: this.userId,
        userName: this.userName,
        email: this.email,
        userPwd: this.userPwd,
      },
      modifyMode: false,
    };
  },
  methods: {
    toggleModify() {
      this.modifyMode = !this.modifyMode;
    },
    modify() {
      console.log('회원수정 : ' + JSON.stringify(this.userInfo));
      modifyUser(
        this.userInfo,
        (response) => {
          alert('수정이 완료되었습니다.');
          console.log('modify success' + response);
        },
        (error) => {
          alert('삭제 처리시 문제가 발생했습니다.');
          console.log('delete error :' + error);
        }
      );

      this.toggleModify();
      this.$emit('update');
    },
    remove() {
      deleteUser(
        { userId: this.userId },
        (response) => {
          alert('삭제가 완료되었습니다.');
          console.log('delete success' + response);
          this.$emit('update');
        },
        (error) => {
          alert('삭제 처리시 문제가 발생했습니다.');
          console.log('delete error :' + error);
        }
      );
    },
  },
};
</script>

<style></style>
