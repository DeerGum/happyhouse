<template>
  <div>
    <b-row >
      <b-col>
        <b-alert show class="notice-write-title"><h3>공지사항 작성</h3></b-alert>
      </b-col>
    </b-row>
    <notice-write-form type="register" />
  </div>
  
</template>

<script>
import NoticeWriteForm from "./child/NoticeWriteForm.vue";

export default {
  name: "NoticeWrite",
  components: {
    NoticeWriteForm,
  },
};
</script>

<style scoped>
  .notice-write-title {
    background-color: #8CBDED;
    color: white;
    text-align: center;
  }

</style>
