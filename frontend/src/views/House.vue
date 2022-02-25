<template>
  <div>
    <div>
      <b-alert show class="user-title"><h3>APARTMENTS</h3></b-alert>
    
  </div>
    <b-container class="house-container">
      <b-container class="bv-example-row mt-3 h-auto text-center">
        <h3 class="house-map-title">
          MAP
        </h3>
        <b-row>
          <b-col>
            <house-search-bar></house-search-bar>
          </b-col>
        </b-row>
        <b-row>
          <b-col cols="6" align="left">
            <house-list />
          </b-col>
        </b-row>
        <b-row>
            <b-col>
                <house-info-modal />
            </b-col>
        </b-row>
      </b-container>
    </b-container>
  </div>
</template>
<script>
import HouseSearchBar from '@/components/house/HouseSearchBar.vue';
import HouseList from '@/components/house/HouseList.vue';
import HouseInfoModal from '@/components/house/HouseInfoModal.vue';
// import HouseMap from "@/components/house/HouseMap.vue";

export default {
  name: 'House',
  components: {
    HouseSearchBar,
    HouseList,
    HouseInfoModal,
    // HouseMap,
  },
};
</script>
<style scoped>
.house-map-title{
  padding-top: 10px;
  color: #8cbded;
}

.house-container {
  border: dashed gray;
}

.user-title {
  background-color: #8cbded;
  color: white;
  text-align: center;
}
</style>
