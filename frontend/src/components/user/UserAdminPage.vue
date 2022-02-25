<template>
  <b-container class="bv-example-row mt-3" v-if="userInfo && userInfo.userId === 'admin'">
    <div class="mypage-logo">
      <img src="@/assets/houselogo.png" width="460px" height="200px" />
    </div>
    <b-row>
      <b-col></b-col>
      <b-col cols="12">
        <b-jumbotron class="mypage-border">
          <template #header>
            <b-alert show variant="primary"><h3>관리자 페이지</h3></b-alert>
          </template>

          <hr class="my-4" />

          <b-row>
            <b-col>
              <b-table-simple hover responsive>
                <b-thead head-variant="dark">
                  <b-tr>
                    <b-th>아이디</b-th>
                    <b-th>이름</b-th>
                    <b-th>이메일</b-th>
                    <b-th>수정/삭제</b-th>
                  </b-tr>
                </b-thead>
                <!-- 하위 component인 ListRow에 데이터 전달(props) -->
                <user-list-row
                  v-for="(userInfo, index) in userInfos"
                  :key="index"
                  v-bind="userInfo"
                  @update="getUserList"
                />
              </b-table-simple>
            </b-col>
          </b-row>
          <hr class="my-4" />
        </b-jumbotron>
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapMutations } from 'vuex';
import { deleteUser, getUserList } from '@/api/user.js';
import UserListRow from '@/components/user/child/UserListRow';

const userStore = 'userStore';

export default {
  name: 'UserAdminPage',
  components: {
    UserListRow,
  },
  computed: {
    ...mapState(userStore, ['userInfo', 'userInfos']),
  },
  created() {
    this.getList();
  },
  methods: {
    ...mapMutations(userStore, ['SET_IS_LOGIN', 'SET_USER_INFO', 'SET_USER_INFO_LIST']),
    delete() {
      deleteUser(
        JSON.stringify(this.userInfo),
        (response) => {
          alert('삭제가 완료되었습니다.');
          console.log('delete success' + response);
          this.SET_IS_LOGIN(false);
          this.SET_USER_INFO(null);
          sessionStorage.removeItem('access-token');
          this.$router.push({ name: 'Home' });
        },
        (error) => {
          alert('삭제 처리시 문제가 발생했습니다.');
          console.log('delete error :' + error);
        }
      );
    },
    async getList() {
      await getUserList(
        (response) => {
        //   console.log('회원 정보 목록 : ' + JSON.stringify(response.data));
          if (response.data.length > 0) {
            this.SET_USER_INFO_LIST(response.data);
          } else {
            console.log('유저 정보 없음!!');
          }
        },
        (error) => {
          console.log(error);
        }
      );
    },
  },
};
</script>

<style>
.mypage-logo {
  text-align: center;
}

.mypage-border {
  text-align: center;
  padding: 20px;
  border: dashed #8cbded;
}

.mypage-userid {
  color: #8cbded;
}
.icon-modify {
  color: chocolate;
  margin-left: 5px;
}
.icon-bookmark {
  color: #ffdc3c;
  margin-left: 5px;
}

</style>
