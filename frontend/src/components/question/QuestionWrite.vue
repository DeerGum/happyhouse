<template>
  <div>
    <b-row >
      <b-col>
        <b-alert show class="qna-write-title"><h3>QnA 작성</h3></b-alert>
      </b-col>
    </b-row>
    <question-write-form type="register" />
  </div>
  
</template>

<script>
import QuestionWriteForm from "./child/QuestionWriteForm.vue";

export default {
  name: "QuestionWrite",
  components: {
    QuestionWriteForm,
  },
};
</script>

<style scoped>
  .qna-write-title {
    background-color: #8CBDED;
    color: white;
    text-align: center;
  }

</style>
