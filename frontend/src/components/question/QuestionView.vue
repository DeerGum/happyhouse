<template>
  <div>
    <div>
      <b-alert show class="guest-book-view-title"><h3>Qna 보기</h3></b-alert>
    </div>
    <b-container class="bv-example-row mt-3">
      <b-row class="mb-1">
        <b-col class="text-left">
          <b-button variant="outline-primary" @click="listArticle">목록</b-button>
        </b-col>
        <b-col class="text-right">
          <b-button
            variant="outline-info"
            size="sm"
            @click="moveModifyArticle"
            class="mr-2"
            v-if="this.userInfo && this.article.userId === this.userInfo.userId"
            >질문수정</b-button
          >
          <b-button
            variant="outline-danger"
            size="sm"
            v-if="this.userInfo && this.article.userId === this.userInfo.userId"
            @click="deleteArticle"
            >질문삭제</b-button
          >
        </b-col>
      </b-row>
      <b-row class="mb-1">
        <b-col>
          <b-card
            :header-html="`<h3>${article.subject} </h3>
            <div><h6>${article.userId}</div><div>${article.regTime}</h6></div>`"
            class="mb-2 text-center"
            border-variant="dark"
            no-body
          >
            <b-card-body class="text-left">
              <div v-html="message"></div>
            </b-card-body>

            <b-card-footer>
              <b-alert show variant="primary" class="notice-view-title-2"
                ><h3>COMMENTS</h3></b-alert
              >
              <b-table-simple hover responsive>
                <b-thead head-variant="dark">
                  <b-tr>
                    <b-th>사항</b-th>
                    <b-th>답변</b-th>
                    <b-th>작성자</b-th>
                    <b-th>작성일</b-th>
                    <b-th></b-th>
                  </b-tr>
                </b-thead>
                <question-view-comment
                  v-for="(targetComment, index) in comments"
                  :key="index"
                  v-bind="targetComment"
                  @update="getComment"
                ></question-view-comment>
              </b-table-simple>
            </b-card-footer>
          </b-card>
        </b-col>
      </b-row>
      <div class="notice-comment-list" v-if="this.userInfo">
        <b-row class="mb-1">
          <b-col style="text-align: left">
            <b-form @submit="onSubmit">
              <b-form-group
                id="userid-group"
                label="답글 작성자:"
                label-for="userid"
              >
                <b-form-input
                  id="userid"
                  :disabled="isUserid"
                  v-model="comment.userId"
                  type="text"
                  required
                  readonly
                ></b-form-input>
              </b-form-group>

              <b-form-group id="content-group" label="답글 내용:" label-for="content">
                <b-form-textarea
                  id="content"
                  v-model="comment.content"
                  placeholder="답글 내용 입력..."
                  rows="10"
                  max-rows="15"
                ></b-form-textarea>
              </b-form-group>

              <b-button type="submit" variant="primary" class="m-1">답변 작성</b-button>
            </b-form>
          </b-col>
        </b-row>
      </div>
      <div class="notice-comment-list" v-else>
          <b-row>
              <b-col>
                <label for="login">
                    로그인 후 댓글 달기를 이용할 수 있습니다.
                </label>
              </b-col>
          </b-row>
      </div>
    </b-container>
  </div>
</template>

<script>
// import moment from "moment";
import { getArticle, getComment, deleteArticle, registComment } from '@/api/board.js';
import QuestionViewComment from '@/components/question/child/QuestionViewComment';
import { mapState } from 'vuex';

const userStore = 'userStore';

export default {
  data() {
    return {
      article: {},
      comment: {
        articleNo: 0,
        userId: '',
        content: '',
      },
      comments: [],
    };
  },
  components: {
    QuestionViewComment,
  },

  computed: {
    ...mapState(userStore, ['userInfo']),
    message() {
      if (this.article.content) return this.article.content.split('\n').join('<br>');
      return '';
    },
  },
  created() {
    this.init();
    if (this.userInfo) // 로그인 상태이면 댓글 유저아이디 설정
        this.comment.userId = this.userInfo.userId;
  },
  methods: {
    async init() {
      await getArticle(
        this.$route.params.articleNo,
        ({ data }) => {
          this.article = data;
          this.comment.articleNo = data.articleNo;
        },
        (error) => {
          console.log('게시글 가져오기 실패 : ' + error);
        }
      );
      await this.getComment();
    },
    async getComment() {
      await getComment(
        this.article.articleNo,
        ({ data }) => {
          this.comments = data;
        },
        (error) => {
          console.log('댓글 가져오기 실패 : ' + error);
        }
      );
    },

    listArticle() {
      this.$router.push({ name: 'QuestionList' });
    },
    moveModifyArticle() {
      this.$router.replace({
        name: 'QuestionUpdate',
        params: { articleNo: this.article.articleNo },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    deleteArticle() {
      deleteArticle(
        this.$route.params.articleNo,
        (response) => {
          alert('삭제가 완료되었습니다.');
          console.log('deleteArticle success' + response);
          this.$router.push({ name: 'QuestionList' });
        },
        (error) => {
          alert('삭제 처리시 문제가 발생했습니다.');
          console.log('deleteArticle error :' + error);
          this.$router.push({ name: 'QuestionList' });
        }
      );

    },

    registComment() {
      registComment(
        this.comment,
        (response) => {
          alert('댓글 등록이 완료되었습니다.');
          console.log('registComment success' + response);
          this.getComment();
        },
        (error) => {
          alert('댓글 등록시 문제가 발생했습니다.');
          console.log('registComment error :' + error);
        }
      );

    },
    
    onSubmit(event) {
      event.preventDefault();

      let err = true;
      let msg = '';
      !this.comment.userId &&
        ((msg = '작성자 입력해주세요'), (err = false), this.$refs.userId.focus());
      err &&
        !this.comment.content &&
        ((msg = '내용 입력해주세요'), (err = false), this.$refs.content.focus());

      if (!err) alert(msg);
      else this.registComment();
    },
  },
};
</script>

<style scoped>
.notice-comment-list {
  border: dashed gray;
  padding: 15px;
}
.guest-book-view-title {
  background-color: #8cbded;
  color: white;
  text-align: center;
}
</style>
