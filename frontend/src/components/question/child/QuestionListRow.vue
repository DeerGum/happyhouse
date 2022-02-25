<template>
  <b-tr>
    <b-td>[ 질문 ]</b-td>
    <b-th class="text-left">
      <router-link
        :to="{ name: 'QuestionView', params: { articleNo: articleNo } }"
        >{{ subject }}</router-link
      >
    </b-th>
    <b-td>{{ userId }}</b-td>
    <b-td>{{ regTime }}</b-td>
  </b-tr>
</template>

<script>
import { mapState } from "vuex";

const userStore = "userStore";

export default {
  name: "QuestionListRow",
  props: {
    articleNo: Number,
    userId: String,
    subject: String,
    regTime: String,
  },
  computed: {
    ...mapState(userStore, ["userInfo"]),
  },
};
</script>

<style></style>
