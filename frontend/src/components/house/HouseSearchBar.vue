<template>
  <b-container>
    <b-row class="mt-4 mb-4 text-center">
      <b-col class="sm-1">
        <b-form-select v-model="sidoCode" :options="sidos" @change="gugunList"></b-form-select>
      </b-col>
      <b-col class="sm-1">
        <b-form-select v-model="gugunCode" :options="guguns" @change="dongList"></b-form-select>
      </b-col>
      <b-col class="sm-1">
        <b-form-select v-model="dongCode" :options="dongs" @change="searchApt"></b-form-select>
      </b-col>
    </b-row>
    <b-row>
      <b-col class="sm-1">
        <div id="map"></div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapActions, mapMutations } from 'vuex';

const houseStore = 'houseStore';

export default {
  name: 'HouseSearchBar',
  data() {
    return {
      sidoCode: null,
      gugunCode: null,
      dongCode: null,

      map: null, //지도 객체
      ps: null, //장소 검색 객체
      geocoder: null, // 주소-좌표 변환 객체
      infoWindow: null, //검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우
      markers: [], // 마커를 담을 배열
      customOverlays: [], // 커스텀 오버레이
      overlayIdx: 0, // 오버레이 인덱스
    };
  },
  mounted() {
    window.kakao && window.kakao.maps ? this.initMap() : this.addScript();
  },
  computed: {
    ...mapState(houseStore, ['sidos', 'guguns', 'dongs', 'houses']),
  },
  created() {
    // this.$store.dispatch("getSido");
    // this.sidoList();
    this.CLEAR_SIDO_LIST();
    this.getSido();
  },
  methods: {
    ...mapActions(houseStore, ['getSido', 'getGugun', 'getDong', 'getHouseList']),
    ...mapMutations(houseStore, ['CLEAR_SIDO_LIST', 'CLEAR_GUGUN_LIST', 'CLEAR_DONG_LIST']),
    gugunList() {
      console.log('gugunList - ' + this.sidoCode);
      this.CLEAR_GUGUN_LIST();
      this.gugunCode = null;
      if (this.sidoCode) this.getGugun(this.sidoCode);
    },
    dongList() {
      console.log('dongList - ' + this.gugunCode);
      this.CLEAR_DONG_LIST();
      this.dongCode = null;
      if (this.gugunCode) this.getDong(this.gugunCode);
    },
    async searchApt() {
      if (this.dongCode) {
        await this.getHouseList(this.dongCode);
        this.displayMarkers(this.houses);
      }
    },

    initMap() {
      let mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(37.564343, 126.947613), // 지도의 중심좌표
          level: 3, // 지도의 확대 레벨
        };
      mapContainer.style.height = '500px';

      this.map = new kakao.maps.Map(mapContainer, mapOption);

      this.ps = new kakao.maps.services.Places();
      this.infoWindow = new kakao.maps.InfoWindow({ zIndex: 1 });
      this.geocoder = new kakao.maps.services.Geocoder();
    },
    addScript() {
      const script = document.createElement('script');
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=[apikey]&libraries=services,clusterer,drawing';
      document.head.appendChild(script);
    },

    displayMarkers(places) {
      let fragment = document.createDocumentFragment();
      let bounds = new kakao.maps.LatLngBounds();
      // 지도에 표시되고 있는 마커를 제거합니다
      this.removeMarker();
      console.log('displayMarkers : ');
      for (var i = 0; i < places.length; i++) {
        let placePosition = new kakao.maps.LatLng(places[i].lat, places[i].lng);
        let marker = this.addMarker(placePosition, i);
        let itemEl = this.getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);
        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function (map, marker, title, code, place, displayInfowindow, removeInfowindow) {
          kakao.maps.event.addListener(marker, 'click', function () {
            displayInfowindow(marker, title, place);
            console.log(title + ' ' + code);
          });

          kakao.maps.event.addListener(map, 'click', function () {
            removeInfowindow();
          });

          itemEl.onmouseover = function () {
            displayInfowindow(marker, title);
          };

          itemEl.onmouseout = function () {
            removeInfowindow();
          };
        })(
          this.map,
          marker,
          places[i].aptName,
          places[i].aptCode,
          places[i],
          this.displayInfowindow,
          this.removeInfowindow
        );

        fragment.appendChild(itemEl);
      }
      // 마커를 생성하고 지도에 표시합니다

      // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
      this.map.setBounds(bounds);
    },
    addMarker(position, idx) {
      //마커 생성하고 지도 위에 마커를 표시
      let imageSrc =
          'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
        imgOptions = {
          spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
          spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
          offset: new kakao.maps.Point(13, 37), // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
          position: position, // 마커의 위치
          image: markerImage,
        });

      marker.setMap(this.map); // 지도 위에 마커를 표출합니다
      this.markers.push(marker); // 배열에 생성된 마커를 추가합니다

      return marker;
    },
    removeMarker() {
      //지도 위에 표시되고 있는 모든 마커 제거
      for (var i = 0; i < this.markers.length; i++) {
        this.markers[i].setMap(null);
      }
      this.markers = [];
    },
    getListItem(index, place) {
      //검색결과 항목을 Element로 반환
      let el = document.createElement('li');
      let itemStr = `
          <span class="markerbg marker_${index + 1}></span>
          <div class="info"><h5>${place.aptName}</h5> <button>관심등록</button>
          <span>${place.sidoName} ${place.gugunName} ${place.dongName} ${place.jibun}</span>
          `;
      el.innerHTML = itemStr;
      el.className = 'item';

      return el;
    },
    displayInfowindow(marker, title, place) {
      //   console.log(title);
      var content = `
          <div class="mapoverlaybox">
              <div class="boxtitle">${title}</div>
              <ul>
                  <li class="up">
                      <span class="title">건축년도</span>
                      <span class="count">${place.buildYear}</span>
                  </li>
                  <li>
                      <span class="title">주소</span>
                      <span class="count">${place.gugunName} ${place.dongName} ${place.jibun}</span>
                  </li>
                  <li>
                      <span class="title">최신거래금액</span>
                      <span class="count">${place.recentPrice}</span>
                  </li>
              </ul>
          </div>
      `;
      let position = new kakao.maps.LatLng(
        marker.getPosition().getLat() + 0.00033,
        marker.getPosition().getLng() - 0.00003
      );
      let customOverlay = new kakao.maps.CustomOverlay({
        position: position,
        content: content,
        xAnchor: 0.3,
        yAnchor: 0.91,
      });

      this.customOverlays[this.overlayIdx] = customOverlay;
      this.customOverlays[this.overlayIdx++].setMap(this.map);
      //	console.log("인덱스 증가 : "+overlayIdx);
    },
    removeInfowindow() {
      if (this.overlayIdx > 0) {
        this.customOverlays[--this.overlayIdx].setMap(null);
      }
      //	console.log("인덱스 감소 : "+overlayIdx);
    },
  },
};
</script>

<style>
.mapoverlaybox {
  position: relative;
  width: 280px;
  height: 200px;
  background-color: rgb(31, 30, 30);
  padding: 15px 10px;
}
.mapoverlaybox div,
ul {
  margin: 0;
  padding: 0;
}
.mapoverlaybox li {
  list-style: none;
}
.mapoverlaybox .boxtitle {
  color: #fff;
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 8px;
}

.mapoverlaybox ul {
  width: 247px;
}
.mapoverlaybox li {
  position: relative;
  margin-bottom: 2px;
  background: #2b2d36;
  padding: 5px 10px;
  color: #aaabaf;
  line-height: 1;
}
.mapoverlaybox li span {
  display: inline;
}
.mapoverlaybox li .number {
  font-size: 16px;
  font-weight: bold;
}
.mapoverlaybox li .title {
  font-size: 13px;
  text-align: left !important;
}
.mapoverlaybox li .last {
  font-size: 12px;
  margin-right: 15px;
}
.mapoverlaybox ul .arrow {
  position: absolute;
  margin-top: 8px;
  right: 25px;
  width: 5px;
  height: 3px;
  background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;
}
.mapoverlaybox li .up {
  background-position: 0 -40px;
}
.mapoverlaybox li .down {
  background-position: 0 -60px;
}
.mapoverlaybox li .count {
  position: absolute;
  margin-top: 5px;
  right: 15px;
  font-size: 10px;
}
.mapoverlaybox li:hover {
  color: #fff;
  background: #d24545;
}
.mapoverlaybox li:hover .up {
  background-position: 0 0px;
}
.mapoverlaybox li:hover .down {
  background-position: 0 -20px;
}
</style>
