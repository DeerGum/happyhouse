<template>
  <tbody>
    <b-tr v-if="!modifyMode">
      <b-td>[ 답변 ]</b-td>
      <b-td> {{ comment.content }} </b-td>
      <b-td> {{ comment.userId }} </b-td>
      <b-td> {{ comment.regTime }} </b-td>
      <b-td>
        <b-button
          variant="outline-info"
          size="sm"
          @click="toggleModify()"
          class="mr-2"
          v-if="this.userInfo && (this.userInfo.userId == comment.userId || this.userInfo.userId == 'admin')"
          >수정</b-button
        >
        <b-button
          variant="outline-danger"
          size="sm"
          @click="deleteComment()"
          v-if="this.userInfo && (this.userInfo.userId == comment.userId || this.userInfo.userId == 'admin')"
          >삭제</b-button
        >
      </b-td>
    </b-tr>
    <b-tr v-if="modifyMode">
      <b-td>[ 답변 ]</b-td>
      <b-td>
        <b-form-input id="text" v-model="comment.content"></b-form-input>
      </b-td>
      <b-td> {{ comment.userId }} </b-td>
      <b-td> {{ comment.regTime }} </b-td>
      <b-td>
        <b-button variant="outline-info" size="sm" @click="modifyComment()" class="mr-2"
          >수정</b-button
        >
        <b-button variant="outline-danger" size="sm" @click="toggleModify()">취소</b-button>
      </b-td>
    </b-tr>
  </tbody>
</template>

<script>
import { mapState } from 'vuex';
const userStore = 'userStore';
import { modifyComment, deleteComment } from '@/api/board.js';

export default {
  name: 'NoticeViewComment',
  props: {
    articleNo: Number,
    commentNo: Number,
    userId: String,
    content: String,
    regTime: String,
  },
  data() {
    return {
      comment: {
        articleNo: this.articleNo,
        commentNo: this.commentNo,
        userId: this.userId,
        content: this.content,
        regTime: this.regTime,
      },
      modifyMode: false,
    };
  },

  computed: {
    ...mapState(userStore, ['userInfo']),
  },
  methods: {
    toggleModify() {
      this.modifyMode = !this.modifyMode;
    },
    deleteComment() {
      deleteComment(
        this.comment,
        (response) => {
          alert('삭제가 완료되었습니다.');
          console.log('deleteComment success' + response);
          this.$emit('update');
        },
        (error) => {
          alert('삭제 처리시 문제가 발생했습니다.');
          console.log('deleteComment error :' + error);
        }
      );
    },
    modifyComment() {
      console.log('수정 전 데이터 :' + JSON.stringify(this.comment));
      modifyComment(
        this.comment,
        (response) => {
          alert('수정이 완료되었습니다.');
          console.log('deleteComment success' + response);
        },
        (error) => {
          alert('삭제 처리시 문제가 발생했습니다.');
          console.log('deleteComment error :' + error);
        }
      );

      this.toggleModify();
      this.$emit('update');
    },
  },
};
</script>

<style scoped>
.notice-comment-row {
  margin: 20px;
}

.notice-comment-userid {
  color: #8cbded;
  width: 10px;
}
</style>
