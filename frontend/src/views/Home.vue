<template>
  <b-container>
    <b-row>
      <b-col></b-col>
      <b-col>
        <div>
          <img src="@/assets/houselogo.png" width="460px" height="200px" />
          <form @submit.prevent="searchData">
            <b-form-input
              type="text"
              v-model="text"
              placeholder="당신의 HAPPYHOUSE를 검색해보세요"
              class="text-center"
            ></b-form-input>
          </form>
        </div>
      </b-col>
      <b-col></b-col>
    </b-row>

    <b-row class="apt-search-result">
      <b-col class="search-list-group" v-if="searches.length">
        <b-list-group v-for="(search, index) in searches" :key="index">
          <b-list-group-item>
            <h6 class="search-member">{{ search.title }}</h6>
            <b-button
              pill
              variant="outline-light"
              class="search-member-pop-over"
              :href="search.url"
              target="_blank"
              v-b-popover.hover.right="search.datetime"
              :title="`${search.contents}`"
            >
              <b-icon icon="book" variant="primary"></b-icon>
            </b-button>
          </b-list-group-item>
        </b-list-group>
      </b-col>

      <b-col v-if="houses.length" class="search-apt">
        <div>
          <b-alert show variant="primary" class="happyhouse-search"><h4>당신의 HAPPYHOUSE를 찾아보세요</h4></b-alert>
        </div>
        <!-- <b-row class="search-apt-title">
          <b-col>시</b-col>
          <b-col>구</b-col>
          <b-col>동</b-col>
          <b-col>아파트 이름</b-col>
        </b-row>
        <b-row v-for="(house, index) in houses" :key="index" show variant="primary" class="search-apt-content">
          <b-col>
            <h6>{{ house.sidoName }}</h6>
          </b-col>
          <b-col>
            <h6>{{ house.gugunName }}</h6>
          </b-col>
          <b-col>
            <h6>{{ house.dongName }}</h6>
          </b-col>
          <b-col>
            <h6>{{ house.aptName }}</h6>
          </b-col>
        </b-row> -->

        <b-table striped hover id="my-table" :items="houses" :per-page="perPage" :current-page="currentPage" small></b-table>
        <b-pagination v-model="currentPage" :total-rows="houses.length" :per-page="perPage" aria-controls="my-table" align="center"></b-pagination>
      </b-col>

    </b-row>

    
  </b-container>
</template>

<script>
import { kakaoFetch } from '@/api/index.js';
// import http from '@/util/http-common';
import { houseDealSearchList } from '@/api/house.js';

export default {
  name: 'Main',

  data() {
    return {
      text: '',
      searches: [],
      houses: [],
      perPage: 15,
      currentPage: 1,
    };
  },
  methods: {
    async searchData() {
      this.searches = [];
      this.houses=[];
      try {
        const inskaka = kakaoFetch(this.text + '아파트');
        const res = await inskaka.get();
        res.data.documents.forEach((search) => {
          search.title = search.title.replace(/<br\/>/gi, '\n');
          search.title = search.title.replace(
            /<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/gi,
            ''
          );
          search.title = search.title.replace(/(<([^>]+)>)/gi, '');
          search.title = search.title.replace(/&gt;/gi, '');
          search.title = search.title.replace(/&lt;/gi, '');
          search.title = search.title.replace(/&nbsp;/gi, '');
          search.title = search.title.replace(/&#39;/gi, '');
          search.title = search.title.replace(/&#34;/gi, '');

          search.contents = search.contents.replace(/<br\/>/gi, '\n');
          search.contents = search.contents.replace(
            /<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/gi,
            ''
          );
          search.contents = search.contents.replace(/(<([^>]+)>)/gi, '');
          search.contents = search.contents.replace(/&nbsp;/gi, '');
          search.contents = search.contents.replace(/&gt;/gi, '');
          search.contents = search.contents.replace(/&lt;/gi, '');
          search.contents = search.contents.replace(/&#39;/gi, '');
          search.contents = search.contents.replace(/&#34;/gi, '');

          search.datetime = search.datetime.substr(0, 10);

          this.searches.push(search);
          console.log(search.datetime);
        });
      } catch (error) {
        console.log(error);
      }

      let params = {
          aptName: this.text,
      }
      houseDealSearchList(
          params,
          ({ data }) => {
              data.forEach((house) => {
                this.houses.push({"아파트명": house.aptName , "시/도": house.sidoName, "구/군": house.gugunName, "동": house.dongName, "가격": house.recentPrice});
                console.log(this.houses);
              });
          },
          (error) => {
              console.log(error);
          }
      );
    },
  },
};
</script>

<style scoped>

.apt-search-result {
  margin-top: 5%;
}
.mouse-over-bgcolor {
  background-color: lightblue;
}
.search-list-group {
  
  border: dashed #8cbded;
}
.search-apt-list-group {

  border: dashed #8cbded;
}
.search-member {
  display: inline;
}
.search-member-pop-over {
  float: right;
}

.search-apt {
  margin-left: 3%;
  border: dashed #8cbded;
}

.happyhouse-search {
  text-align: center;
}
</style>
