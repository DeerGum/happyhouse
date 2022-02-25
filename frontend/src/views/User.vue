<template>
  <div>
    <b-alert show class="user-title"><h3>USER</h3></b-alert>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "User",
};
</script>

<style scoped>
.user-title {
  background-color: #8cbded;
  color: white;
  text-align: center;
}
</style>
