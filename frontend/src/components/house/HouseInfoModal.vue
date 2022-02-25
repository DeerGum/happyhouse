<template>
  <b-container>
    <b-modal
      size="lg"
      no-close-on-esc
      no-close-on-backdrop
      ok-only
      ok-title="돌아가기"
      @close="closeHouseDealModal"
      @ok="closeHouseDealModal"
      v-model="houseDealModal"
      :title="`${houseDeals[0].aptName} 거래내역`"
    >
      <b-row>
        <b-col>
          <b-table-simple hover responsive>
            <b-thead head-variant="dark">
              <b-tr>
                <b-th>이름</b-th>
                <b-th>거래 날짜</b-th>
                <b-th>거래 금액</b-th>
              </b-tr>
            </b-thead>
            <!-- 하위 component에 데이터 전달(props) -->
            <house-deal-detail
              v-for="(houseDeal, index) in houseDeals"
              :key="index"
              v-bind="houseDeal"
            />
          </b-table-simple>
        </b-col>
      </b-row>
    </b-modal>
  </b-container>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import HouseDealDetail from '@/components/house/HouseDealDetail';

const houseStore = 'houseStore';

export default {
  name: 'HouseInfoModal',
  data() {
    return {
      fields: [
        {
          key: 'aptName',
          label: '아파트 이름',
        },
        {
          key: 'dealDay',
          label: '거래일',
        },
        {
          key: 'dealAmount',
          label: '거래 금액',
        },
      ],
    };
  },
  components: {
    HouseDealDetail,
  },
  computed: {
    ...mapState(houseStore, ['houseDealModal', 'houseDeals']),
  },
  methods: {
    ...mapActions(houseStore, ['offHouseDealModal']),
    closeHouseDealModal() {
      this.offHouseDealModal();
    },
  },
};
</script>

<style scoped>
.modal-table{
  border: dashed blue;
}
</style>
