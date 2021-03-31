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
                                <li class="active"><router-link to="/member/info">회원정보 변경</router-link></li>
                                <li><router-link to="/member/pwd">비밀번호 변경</router-link></li>
                                <li v-if="this.$store.state.user.m_sno == 0"><router-link to="/member/mgt">회원관리</router-link></li>
                            </ul>
                        </nav>
                        <table class="table notice account">
                            <tbody>
                                <tr>
                                    <th colspan="1">
                                        프로필 사진
                                    </th>
                                    <td colspan="2">
                                        <div class="filebox">
                                            <input class="upload-name" :value="this.$store.state.user.m_f_name == null ? '파일선택' : this.$store.state.user.m_f_name" disabled="disabled">
                                            <label for="input-file">업로드</label>
                                            <input @change="uploadFile($event.target.files, 0)" type="file" id="input-file" class="upload-hidden" hidden>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        직급
                                    </th>
                                    <td colspan="2">
                                        {{this.$store.state.user.m_pos}}
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        아이디
                                    </th>
                                    <td colspan="2">
                                        {{this.$store.state.user.m_id}}
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        이름
                                    </th>
                                    <td colspan="2">
                                        {{this.$store.state.user.m_name}}
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        이메일<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="param.m_email" ref="email" type="email" placeholder="이메일을 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        휴대폰 번호<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="param.m_phone" ref="phone" type="text" placeholder="'-'없이 입력">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        주소<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="param.m_address" ref="address" type="text" placeholder="주소를 입력해 주세요">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="edit clearfix">
                            <input @click="updateMember()" type="button" value="수정">
                            <router-link to="/main">취소</router-link>
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
            param: {
                m_email: "",
                m_phone: "",
                m_address: "",
            },
            mSno: "",
            files: []
        }
    },
    created() {
        this.$redirect("/member/check", !this.$store.state.pwdChk);

        this.param.m_email = this.$store.state.user.m_email;
        this.param.m_phone = this.$store.state.user.m_phone;
        this.param.m_address = this.$store.state.user.m_address;
        this.mSno = this.$store.state.user.m_sno;
    },
    methods: {
        async updateMember() {
            let vald = this.validation();
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
                    await this.$api("/api/updateMember",{param:[this.param, this.mSno]});
                    for(let i = 0; i < this.files.length; i++){
                        this.insertMemberFile(i);
                    }
                    setTimeout(() => {
                        this.reset();
                    }, 1000);
                }
            })
        },
        async insertMemberFile(index) {
            let name = "";
            let data = null;
            let mSno = this.$store.state.user.m_sno;
            if (this.files[index].length > 0) {
                name = this.files[index][0].name;
                data = await this.$base64(this.files[index][0]);
                const { error } = await this.$api(`/profile/${mSno}/${name}`, { data });
                if (error) {
                    this.$swal.fire({
                        title: '실패!',
                        text: '파일 업로드를 실패했습니다',
                        icon: 'warning',
                        confirmButtonText: '확인',
                    });
                    return;
                }
                this.$store.state.user.m_f_name = name;
            }
        },
        uploadFile(file, index) {
            this.files[index] = file;
        },
        validation() {
            let b = true;
            let text = "";

            if(this.param.m_email == null || this.param.m_email.trim() == "") {
                text = "이메일을 입력해 주세요";
                this.$refs.email.focus();
                b = false;
            } else if(this.param.m_phone == null || this.param.m_phone.trim() == "") {
                text = "휴대폰 번호를 입력해 주세요";
                this.$refs.phone.focus();
                b = false;
            } else if(this.param.m_address == null || this.param.m_address.trim() == "") {
                this.$refs.address.focus();
                text = "주소를 입력해 주세요";
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
        async reset() {
            let mSno = this.$store.state.user.m_sno;
            let result = await this.$api("/api/selectMember",{param:[mSno]});
            if(result[0].cnt <= 0) {
                this.$swal.fire({
                    text: '아이디 또는 비밀번호가 잘못되었습니다',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
            } else {
                this.$store.commit("user", result[0]);
            }
        }
    }
}
</script>