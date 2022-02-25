import axios from "axios";
import { API_BASE_URL, APT_DEAL_URL } from "@/config";

// axios 객체 생성
function apiInstance() {
  const instance = axios.create({
    baseURL: API_BASE_URL,
    headers: {
      "Content-type": "application/json",
    },
  });
  return instance;
}

function houseInstance() {
  const instance = axios.create({
    baseURL: APT_DEAL_URL,
    headers: {
      "Content-type": "application/json",
    },
  });
  return instance;
}

function kakaoFetch(keyword) {
  return axios.create({
    baseURL:"https://dapi.kakao.com/v2/search/web",
    headers: {
      Authorization : "KakaoAK [api key]",
    },
    params:{query:keyword},
  });
}

export { apiInstance, houseInstance, kakaoFetch };
