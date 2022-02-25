import { apiInstance } from "./index.js";

const api = apiInstance();

function sidoList(success, fail) {
  api.get(`/map/sido`).then(success).catch(fail);
}

function gugunList(params, success, fail) {
  api.get(`/map/gugun`, { params: params }).then(success).catch(fail);
}

function dongList(params, success, fail) {
  api.get(`/map/dong`, { params: params }).then(success).catch(fail);
}

async function houseList(params, success, fail) {
  await api.get(`/map/apt`, { params: params }).then(success).catch(fail);
}

async function houseDealList(params, success, fail) {
  await api.get(`/map/list`, { params: params }).then(success).catch(fail);
}

async function houseDealSearchList(params, success, fail) {
  await api.get(`/map/search`, { params: params }).then(success).catch(fail);
}

export { sidoList, gugunList, dongList, houseList, houseDealList, houseDealSearchList };
