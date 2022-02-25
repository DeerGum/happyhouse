import { sidoList, gugunList, dongList, houseList, houseDealList } from '@/api/house.js';

const houseStore = {
  namespaced: true,
  state: {
    sidos: [{ value: null, text: '선택하세요' }],
    guguns: [{ value: null, text: '선택하세요' }],
    dongs: [{ value: null, text: '선택하세요.' }],
    houses: [],
    house: null,
    houseDeals: null,
    houseDealModal: false, //모달 토글
  },

  getters: {},

  mutations: {
    SET_SIDO_LIST(state, sidos) {
      sidos.forEach((sido) => {
        state.sidos.push({
          value: sido.sidoCode,
          text: sido.sidoName,
        });
      });
    },
    SET_GUGUN_LIST(state, guguns) {
      guguns.forEach((gugun) => {
        state.guguns.push({
          value: gugun.gugunCode,
          text: gugun.gugunName,
        });
      });
    },
    SET_DONG_LIST(state, dongs) {
      dongs.forEach((dong) => {
        state.dongs.push({
          value: dong.dongCode,
          text: dong.dongName,
        });
      });
    },
    SET_HOUSE_LIST(state, houses) {
      state.houses = houses;
    },
    SET_DETAIL_HOUSE(state, house) {
      state.house = house;
    },
    SET_HOUSEDEAL_LIST(state, houseDeals) {
      state.houseDeals = houseDeals;
    },
    SET_HOUSEDEAL_MODAL(state, isShow) {
      state.houseDealModal = isShow;
    },
    TOGGLE_HOUSEDEAL_MODAL(state) {
      state.houseDealModal = !state.houseDealModal;
    },
    CLEAR_SIDO_LIST(state) {
      state.sidos = [{ value: null, text: '선택하세요' }];
    },
    CLEAR_GUGUN_LIST(state) {
      state.guguns = [{ value: null, text: '선택하세요' }];
    },
    CLEAR_DONG_LIST(state) {
      state.dongs = [{ value: null, text: '선택하세요' }];
    },
  },

  actions: {
    getSido: ({ commit }) => {
      sidoList(
        ({ data }) => {
          // console.log(data);
          commit('SET_SIDO_LIST', data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getGugun: ({ commit }, sidoCode) => {
      const params = {
        sido: sidoCode,
      };
      gugunList(
        params,
        ({ data }) => {
          // console.log(commit, response);
          commit('SET_GUGUN_LIST', data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    getDong: ({ commit }, gugunCode) => {
      const params = {
        gugun: gugunCode,
      };
      dongList(
        params,
        ({ data }) => {
          commit('SET_DONG_LIST', data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    async getHouseList({ commit }, dongCode) {
      const params = {
        dong: dongCode,
      };
      await houseList(
        params,
        ({ data }) => {
          console.log('apt : ' + JSON.stringify(data));
          commit('SET_HOUSE_LIST', data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    detailHouse: ({ commit }, house) => {
      // 나중에 house.일련번호를 이용하여 API 호출
      commit('SET_DETAIL_HOUSE', house);
    },
    getHouseDealList: ({ commit }, aptCode) => {
      const params = {
        aptCode: aptCode,
      };
      houseDealList(
        params,
        ({ data }) => {
          commit('SET_HOUSEDEAL_LIST', data);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    onHouseDealModal: ({ commit }) => {
      commit('SET_HOUSEDEAL_MODAL', true);
    },
    offHouseDealModal: ({ commit }) => {
      commit('SET_HOUSEDEAL_MODAL', false);
    },
    toggleHouseDealModal: ({ commit }) => {
      commit('TOGGLE_HOUSEDEAL_MODAL');
    },
  },
};

export default houseStore;
