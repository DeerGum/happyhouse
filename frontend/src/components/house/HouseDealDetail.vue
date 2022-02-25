<template>
  <tbody>
    <b-tr v-if="!modifyMode">
      <b-td>{{ this.aptName }}</b-td>
      <b-td>{{ dealYear }}-{{ dealMonth }}-{{ dealDay }}</b-td>
      <b-td>{{ (parseInt(this.dealAmount.replace(',', '')) * 10000) | price }}원</b-td>
    </b-tr>
  </tbody>
</template>

<script>

export default {
  name: 'HouseDealDetail',
  props: {
    aptCode: String,
    aptName: String,
    dealYear: String,
    dealMonth: String,
    dealDay: String,
    dealAmount: String,
  },
  filters: {
    price(value) {
      if (!value) return value;
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    },
  },

};
</script>

<style></style>
