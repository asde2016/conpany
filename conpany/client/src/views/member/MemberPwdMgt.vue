<template>
    <div class="container">
        <Header />
        <section id="section">
            <SubHeader title="계정관리"/>
            <div class="section_inner">
                <div class="board_container">
                    <div class="table_wrapper">
                        <nav id="sub_nav">
                            <ul>
                                <li><router-link to="/member/info">회원정보 변경</router-link></li>
                                <li class="active"><router-link to="/member/pwd">비밀번호 변경</router-link></li>
                                <li v-if="this.$store.state.user.m_sno == 0"><router-link to="/member/mgt">회원관리</router-link></li>
                            </ul>
                        </nav>
                        <table class="table notice account">
                            <tbody>
                                <tr>
                                    <th colspan="1">
                                        현재 비밀번호<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="oldPwd" ref="oldPwd" type="password" placeholder="비밀번호를 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        비밀번호<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="newPwd" ref="newPwd" type="password" placeholder="비밀번호를 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        비밀번호 확인<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="pwdChk" ref="pwdChk" type="password" placeholder="비밀번호를 다시 입력해 주세요">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="edit clearfix">
                            <input @click="updateMember()" type="button" value="수정">
                            <a href="#">취소</a>
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
            oldPwd: "",
            newPwd: "",
            pwdChk: ""
        }
    },
    created() {
        this.$redirect("/member/check", !this.$store.state.pwdChk);
        
        this.id = this.$store.state.user.m_id;
    },
    methods: {
        async loginCheck() {
            let vald = this.validation();
            if(!vald) return;

            let result = await this.$api("/api/loginCheck",{param:[this.id, this.oldPwd]});
            if(result[0].cnt <= 0) {
                this.$swal.fire({
                    text: '현재 비밀번호가 잘못되었습니다',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
                return true;
            } else {
                return false;
            }
        },
        async updateMember() {
            let vald = this.validation();
            if(!vald) return;
            vald = this.loginCheck();
            if(!vald) return;

            this.$swal.fire({
                title: '수정 하시겠습니까?',
                showCancelButton: true,
                confirmButtonColor: '#00539c',
                confirmButtonText: '수정',
                cancelButtonColor: '#333',
                cancelButtonText: '취소',
            }).then(async (result) => {
                if (result.isConfirmed) {
                    this.$swal.fire({
                        title: '수정!',
                        text: '수정이 완료 됐습니다',
                        icon: 'success',
                        confirmButtonText: '확인',
                    });
                    await this.$api("/api/updatePwd",{param:[this.newPwd, this.id]});
                    this.reset();
                }
            })
        },
        validation() {
            let b = true;
            let text = "";

            if(this.newPwd == this.oldPwd) {
                text = "변경하려는 비밀번호가 같습니다."
                this.$refs.newPwd.focus();
                b = false;
            }

            if(this.newPwd != this.pwdChk) {
                text = "비밀번호를 확인해 주세요"
                this.$refs.pwdChk.focus();
                b = false;
            }

            if(this.oldPwd.trim() == "") {
                text = "현재 비밀번호를 입력해 주세요";
                this.$refs.oldPwd.focus();
                b = false;
            } else if(this.newPwd.trim() == "") {
                text = "비밀번호 입력해 주세요";
                this.$refs.newPwd.focus();
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
        reset() {
            this.oldPwd = "";
            this.newPwd = "";
            this.pwdChk = "";
        }
    }
}
</script>