<template>
    <div class="container">
        <Header />
        <section id="section">
            <SubHeader title="계정관리"/>
            <div class="section_inner">
                <div class="board_container">
                    <div class="title clearfix">
                        <div class="text">
                            회원님의 정보 보호를 위하여 다시 한 번 로그인해 주시기 바랍니다
                        </div>
                    </div>
                    <div class="table_wrapper">
                        <table class="table notice account">
                            <thead>
                                <tr>
                                    <th colspan="1">
                                        아이디
                                    </th>
                                    <td colspan="2">
                                        {{id}}
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        현재 비밀번호<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="pwd" type="password" placeholder="비밀번호를 입력해주세요">
                                    </td>
                                </tr>
                            </thead>
                        </table>
                        <div class="edit clearfix">
                            <input @click="login()" type="button" value="확인">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import Header from '../header/Header.vue'
import SubHeader from '../header/SubHeader.vue'
export default {
    components: {
        Header,
        SubHeader
    },
    data() {
        return {
            id: "",
            pwd: ""
        }
    },
    created() {
        if(this.$store.state.pwdChk) {
            this.$router.push({path: "/member/info"});
        } 

        this.id = this.$store.state.user.m_id;
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
                    text: '비밀번호가 잘못되었습니다',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
            } else {
                this.$store.commit("pwdChk", true);
                this.$router.push({path: '/member/info'});
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
    }
}
</script>