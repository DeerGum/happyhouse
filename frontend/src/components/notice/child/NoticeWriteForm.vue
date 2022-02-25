<template>
  <b-container>
    <div class="write-form-border">
      <b-row class="mb-1">
        <b-col style="text-align: left">
          <b-form @submit="onSubmit" @reset="onReset">
            <b-form-group
              id="userid-group"
              label="작성자:"
              label-for="userId"
              description="작성자를 입력하세요."
            >
              <b-form-input
                id="userId"
                v-model="article.userId"
                type="text"
                required
                placeholder="작성자 입력..."
                readonly
              ></b-form-input>
            </b-form-group>

            <b-form-group
              id="subject-group"
              label="제목:"
              label-for="subject"
              description="제목을 입력하세요."
            >
              <b-form-input
                id="subject"
                v-model="article.subject"
                type="text"
                required
                placeholder="제목 입력..."
              ></b-form-input>
            </b-form-group>

            <b-form-group id="content-group" label="내용:" label-for="content">
              <b-form-textarea
                id="content"
                v-model="article.content"
                placeholder="내용 입력..."
                rows="10"
                max-rows="15"
              ></b-form-textarea>
            </b-form-group>

            <b-button type="submit" variant="primary" class="m-1" v-if="this.type === 'register'"
              >글작성</b-button
            >
            <b-button type="submit" variant="primary" class="m-1" v-else>글수정</b-button>
            <b-button type="reset" variant="danger" class="m-1">초기화</b-button>
          </b-form>
        </b-col>
      </b-row>
    </div>
  </b-container>
</template>

<script>
import { getArticle, writeArticle, modifyArticle } from '@/api/board.js';
import { mapState } from 'vuex';

const userStore = 'userStore';

export default {
  name: 'NoticeWriteForm',
  data() {
    return {
      article: {
        articleNo: 0,
        boardType: 1,
        userId: '',
        subject: '',
        content: '',
      },
    };
  },
  props: {
    type: { type: String },
  },
  computed: {
    ...mapState(userStore, ['userInfo']),
  },

  created() {
    this.article.userId = this.userInfo.userId; //현재 로그인 된 아이디를 작성자로 설정
    if (this.type === 'modify') {
      getArticle(
        this.$route.params.articleNo,
        ({ data }) => {
          this.article = data;
        },
        (error) => {
          console.log('게시글 가져오기 실패 : ' + error);
        }
      );
    } else if (this.type === 'register') {
      console.log(userStore.userInfo.userId);
      this.article.userId = userStore.userInfo.userId;
    }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();

      let err = true;
      let msg = '';
      !this.article.userId &&
        ((msg = '작성자 입력해주세요'), (err = false), this.$refs.userId.focus());
      err &&
        !this.article.subject &&
        ((msg = '제목 입력해주세요'), (err = false), this.$refs.subject.focus());
      err &&
        !this.article.content &&
        ((msg = '내용 입력해주세요'), (err = false), this.$refs.content.focus());

      if (!err) alert(msg);
      else this.type === 'register' ? this.registArticle() : this.modifyArticle();
    },
    onReset(event) {
      event.preventDefault();
      this.article.articleNo = 0;
      this.article.subject = '';
      this.article.content = '';
      this.$router.push({ name: 'NoticeWrite' });
    },
    registArticle() {
      writeArticle(
        this.article,
        (response) => {
          alert('공지사항 등록이 완료되었습니다.');
          console.log('registNotice success' + response);
          this.$router.push({ name: 'NoticeList' });
        },
        (error) => {
          alert('공지사항 등록시 문제가 발생했습니다.');
          console.log('registNotice error :' + error);
          this.$router.push({ name: 'NoticeList' });
        }
      );
    },
    modifyArticle() {
      modifyArticle(
        this.article,
        (response) => {
          alert('수정이 완료되었습니다.');
          console.log('modifyNotice success' + response);
          this.$router.push({ name: 'NoticeList' });
        },
        (error) => {
          alert('수정 처리시 문제가 발생했습니다.');
          console.log('modifyNotice error :' + error);
          this.$router.push({ name: 'NoticeList' });
        }
      );
    },
    moveList() {
      this.$router.push({ name: 'NoticeList' });
    },
  },
};
</script>

<style scoped>
.write-form-border {
  border: dashed gray;
  padding: 30px;
}
</style>
