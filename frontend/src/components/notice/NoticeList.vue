<template>
  <div>
    <b-row>
      <b-col>
        <b-alert show class="community-title text-dark"><h3>NOTICE</h3></b-alert>
      </b-col>
    </b-row>

    <b-container class="community-container">
      <b-row>
        <b-col class="text-right">
          <b-form-select v-model="selected" :options="options" class="mb-3"> </b-form-select>
        </b-col>
        <b-col>
          <b-form-input
            v-model="keyword"
            placeholder="검색어를 입력하세요"
            class="search-tag"
          ></b-form-input>
        </b-col>
        <b-col>
          <b-button variant="primary" @click="initArticle()" class="notice-write-button"
            >검색</b-button
          >
        </b-col>
        <b-col class="text-right">
          <!--<b-dropdown split text="글작성" variant="outline-primary">
            <b-dropdown-item @click="moveWrite()">공지사항 작성</b-dropdown-item>
            <b-dropdown-item @click="moveWrite()">QnA 작성</b-dropdown-item>
          </b-dropdown>-->
          <b-button
            variant="primary"
            @click="moveWrite()"
            class="notice-write-button"
            v-if="this.userInfo && this.userInfo.userId == 'admin'"
            >공지사항 작성</b-button
          >
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <b-alert show class="community-list-title"><h3>공지사항 게시판</h3></b-alert>
        </b-col>
      </b-row>
      <b-row class="mb-1"> </b-row>
      <b-row>
        <b-col v-if="articles.length">
          <b-table-simple hover responsive :per-page="perPage" :current-page="currentPage">
            <b-thead head-variant="dark">
              <b-tr>
                <b-th>사항</b-th>
                <b-th>제목</b-th>
                <b-th>작성자</b-th>
                <b-th>작성일</b-th>
              </b-tr>
            </b-thead>
            <tbody>
              <!-- 하위 component인 ListRow에 데이터 전달(props) -->
              <notice-list-row
                v-for="(article, index) in articles"
                :key="index"
                v-bind="article"
              />
            </tbody>
          </b-table-simple>
        </b-col>
        <!-- <b-col v-else class="text-center">도서 목록이 없습니다.</b-col> -->
      </b-row>
      <b-pagination
        align="center"
        v-model="currentPage"
        :total-rows="articleTotalCount"
        :per-page="perPage"
      ></b-pagination>
    </b-container>
  </div>
</template>

<script>
import { mapState } from 'vuex';
import NoticeListRow from '@/components/notice/child/NoticeListRow';
import { listArticle, listArticleTotalCount } from '@/api/board.js';

const userStore = 'userStore';
export default {
  name: 'NoticeList',
  components: {
    NoticeListRow,
  },
  data() {
    return {
      articles: [],
      selected: null,
      keyword: null,
      options: [
        { value: null, text: '-- 조건 --' },
        { value: 'userId', text: '아이디' },
        { value: 'subject', text: '제목' },
      ],
      perPage: 10,
      currentPage: 1,
      articleTotalCount: 0,
    };
  },
  computed: {
    ...mapState(userStore, ['userInfo']),
  },
  watch: {
    currentPage: 'getArticle',
  },
  created() {
    this.initArticle();
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: 'NoticeWrite' });
    },
    initArticle() {
        this.getArticle();
        this.getArticleTotalCount();
    },
    getArticle() {
      let param = {
        boardType: 1,
        pg: this.currentPage,
        spp: this.perPage,
        key: this.selected,
        word: this.keyword,
      };
      listArticle(
        param,
        (response) => {
          this.articles = response.data;
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getArticleTotalCount() {
      let param = {
        boardType: 1,
        key: this.selected,
        word: this.keyword,
      };
      listArticleTotalCount(
        param,
        (response) => {
          this.articleTotalCount = response.data;
        },
        (error) => {
          console.log(error);
          return 0;
        }
      );
    },
  },
};
</script>

<style scoped>
.tdClass {
  width: 50px;
  text-align: center;
}
.tdSubject {
  width: 300px;
  text-align: left;
}
.community-title {
  background-color: #8cbded;
  color: white;
  text-align: center;
}

.notice-write-button {
  background-color: #8cbded;
  border-color: #8cbded;
}

.community-list-title {
  background-color: gray;
  border-color: gray;
  color: white;
  text-align: center;
}

.mb-3 {
  width: 150px;
}

.search-tag {
  width: 300px;
}
.community-container {
  border: dashed gray;
  padding: 30px;
}
.btn-cover{
  text-align: center;
  color:cornflowerblue;
}
</style>
