<template>
  <div class="container">
        <div class="content">
            <div class="logo">
                <h1><img src="@/assets/images/logo.png" alt="logo"></h1>
            </div>
            <div class="login">
                <input v-model="id" type="text" placeholder="아이디">
                <input v-model="pwd"  type="password" placeholder="비밀번호">
                <input @click="login()" type="button" value="로그인">
                <a @click="forgetPwd" href="#">비밀번호를 잊으셨나요?</a>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            id: "",
            pwd: ""
        }
    },
    created() {
        let user = this.$store.state.user;
        let length = Object.keys(user).length;
        if(length != 0) {
            this.$router.push({path:"/main"});
        }
    },
    methods: {
        login() {
            this.loginCheck();
        },
        async loginCheck() {
            let vald = this.validation();
            if(!vald) return;

            let result = await this.$api("/api/loginCheck",{param:[this.id, this.pwd]});
            if(result[0].cnt <= 0) {
                this.$swal.fire({
                    text: '아이디 또는 비밀번호가 잘못되었습니다',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
            } else {
                this.$store.commit("user", result[0]);
                this.$router.push({path: '/main'});
                this.$swal.fire({
                    title: '로그인!',
                    text: '로그인 했습니다',
                    icon: 'success',
                    confirmButtonText: '확인',
                });
            }
        },
        validation() {
            let b = true;
            let text = "";

            if(this.id == "") {
                text = "아이디를 입력해 주세요";
                b = false;
            } else if(this.pwd == "") {
                text = "비밀번호를 입력해 주세요";
                b = false;
            }

            if(!b) {
                this.$swal({
                    text: text,
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
            }
            return b;
        },
        forgetPwd(){
            this.$swal.fire({
                text: '관리자에게 문의',
                icon: 'warning',
                confirmButtonText: '확인',
            });
        }
    }
}
</script>
