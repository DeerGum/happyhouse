<template>
  <b-tr>
    <b-td>[ 공지 ]</b-td>
    <b-th class="text-left">
      <router-link
        :to="{ name: 'NoticeView', params: { articleNo: articleNo } }"
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
  name: "NoticeListRow",
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
