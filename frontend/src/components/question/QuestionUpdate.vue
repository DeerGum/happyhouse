<template>
  <b-container class="bv-example-row mt-3">
    <b-row>
      <b-col>
        <b-alert show class="guest-book-view-title"><h3>질문사항 수정</h3></b-alert>
      </b-col>
    </b-row>
    <question-write-form type="modify" />
  </b-container>
</template>

<script>
import QuestionWriteForm from "./child/QuestionWriteForm.vue";

export default {
  name: "QuestionUpdate",
  components: {
    QuestionWriteForm,
  },
};
</script>

<style scoped>
.guest-book-view-title{
    background-color: #8cbded;
    color: white;
    text-align: center;
  }
</style>
