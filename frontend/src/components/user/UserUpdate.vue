<template>
    <b-container class="bv-example-row mt-3">
        <div class="login-logo">
        <img src="@/assets/houselogo.png" width="460px" height="200px"/>
        </div>
        <b-row></b-row>
        <b-row>
        <b-col></b-col>
        <b-col cols="8">
            <b-card class="login-form-border text-center mt-3" style="max-width: 40rem" align="left">
            <h3 class="login-login">회원 정보 수정</h3>
            <b-form class="login-form-form">
                <b-form-group label="NAME" label-for="userName" class="join-label">
                <b-form-input
                    id="userName"
                    v-model="userInfo.userName"
                    required
                    placeholder="이름을 입력하세요.."
                    @keyup.enter="confirm"
                ></b-form-input>
                </b-form-group>
                <b-form-group label="ID" label-for="userid" class="join-label">
                <b-form-input
                    id="userid"
                    v-model="userInfo.userId"
                    required
                    readonly
                    placeholder="아이디를 입력하세요.."
                    @keyup.enter="confirm"
                ></b-form-input>
                </b-form-group>
                <b-form-group label="PASSWORD" label-for="userpwd" class="join-label">
                <b-form-input
                    type="password"
                    id="userpwd"
                    v-model="userInfo.userPwd"
                    required
                    placeholder="비밀번호를 입력하세요.."
                    @keyup.enter="confirm"
                ></b-form-input>
                </b-form-group>
                <b-form-group label="E-MAIL" label-for="email" class="join-label">
                <b-form-input
                    type="email"
                    id="email"
                    v-model="userInfo.email"
                    required
                    placeholder="이메일을 입력하세요.."
                    @keyup.enter="confirm"
                ></b-form-input>
                </b-form-group>
                <b-button
                type="button"
                variant="primary"
                class="login-button m-1"
                @click="modify()"
                >수정</b-button
                >
            </b-form>
            </b-card>
        </b-col>
        <b-col></b-col>
        </b-row>
        <b-row class="login-alert">
        <b-col></b-col>
        <b-col></b-col>
        <b-col></b-col>
        </b-row>
    </b-container>
</template>

<script>
import { modifyUser } from "@/api/user.js";
import { mapState } from "vuex";

const userStore = "userStore";

export default {
    name: "UserJoin",
    data() {
        return {
            user: {
                userName: "",
                userId: "",
                userPwd: "",
                email: "",
                joinDate: "",
            },
        };
    },
    props: {
        type: { type: String },
    },
    computed: {
        ...mapState(userStore, ["userInfo"]),
    },
    methods: {
        modify() {
            modifyUser((this.user),
            (response) => {
                alert("수정이 완료되었습니다.");
                console.log(this.user)
                console.log("modify success" + response);
                this.$router.push({ name: "SignIn" });
            },
            (error) => {
                alert("수정 처리 중 문제가 발생했습니다.");
                console.log("modify error :" + error);
            });
        },
    },
};
</script>

<style scoped>
    .login-logo {
        text-align: center;
    }

    .login-form-border {
        text-align: center;
        margin-left: 190px;
        width: 350px;
        height: 550px;
        padding: 20px;
        border: dashed #8CBDED;
    }

    .login-button {
        background-color: #8CBDED;
        border-color: #8CBDED;
    }

    .login-login {
        color: #8CBDED;
    }

    .login-form-form {
        margin-top: 30px;
    }

    .login-alert {
        margin-top: 30px;
        margin-left: 10px;
    }

    .join-label {
        color:#6A5ACD;
    }

</style>