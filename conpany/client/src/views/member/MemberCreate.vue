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
                                <li><router-link to="/member/pwd">비밀번호 변경</router-link></li>
                                <li v-if="this.$store.state.user.m_sno == 0" class="active"><router-link to="/member/mgt">회원관리</router-link></li>
                            </ul>
                        </nav>
                        <table class="table account">
                            <tbody>
                                <tr>
                                    <th colspan="1">
                                        직급<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="member.m_pos" type="text" ref="pos" placeholder="직급을 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        부서<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <div class="select_wrapper">
                                            <select v-model="member.d_sno">
                                                <option :key="i" v-for="(dept, i) in deptListFilter" :value="dept.d_sno">{{dept.d_name}}</option>
                                            </select>
                                            <i class="fas fa-chevron-down"></i>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        아이디<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="member.m_id" type="text" ref="id" placeholder="아이디를 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        비밀번호<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="member.m_pwd" type="password" ref="pwd" placeholder="비밀번호를 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        비밀번호 확인<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="pwdChk" type="password" ref="pwdChk" placeholder="비밀번호를 다시 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        이름<span class="star">*</span>
                                    </th>
                                    <td colspan="2">
                                        <input v-model="member.m_name" type="text" ref="name" placeholder="이름을 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        이메일
                                    </th>
                                    <td colspan="2">
                                        <input v-model="member.m_email" type="email" placeholder="이메일을 입력해 주세요">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        휴대폰 번호
                                    </th>
                                    <td colspan="2">
                                        <input v-model="member.m_phone" type="text" placeholder="'-'없이 입력">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        주소
                                    </th>
                                    <td colspan="2">
                                        <input v-model="member.m_address" type="text" placeholder="주소를 입력해 주세요">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="edit clearfix">
                            <input @click="insertMember()" type="button" value="등록">
                            <a @click="this.$router.go(-1)" href="#">취소</a>
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
            departmentList: [],
            member: {
                m_pos: "",
                d_sno: 1,
                m_id: "",
                m_pwd: "",
                m_name: "",
                m_email: "",
                m_phone: "",
                m_address: "",
            },
            pwdChk: ""
        }
    },
    created() {
        let user = this.$store.state.user;
        this.$redirect("/", user.m_sno != 0);
        
        this.getDepartment();
    },
    computed: {
        deptListFilter() {
            let list = this.departmentList.filter(dept => 
                       dept.d_sno > 0);

            return list;
        }
    },
    methods: {
        async getDepartment() {
            this.departmentList = await this.$api("/api/departmentList");
        },
        async insertMember() {
            let vald = this.validation();
            if(!vald) return;
            vald = this.MemberIdCheck();
            if(!vald) return;

            this.$swal.fire({
                title: '등록 하시겠습니까?',
                showCancelButton: true,
                confirmButtonColor: '#00539c',
                confirmButtonText: '등록',
                cancelButtonColor: '#333',
                cancelButtonText: '취소',
            }).then(async (result) => {
                if (result.isConfirmed) {
                    this.$swal.fire({
                        title: '등록!',
                        text: '등록이 완료 됐습니다',
                        icon: 'success',
                        confirmButtonText: '확인',
                    });
                    await this.$api("/api/insertMember",{param:[this.member]});
                    this.$router.push({path:'/member/mgt'});
                }
            })
        },
        async MemberIdCheck() {
            let result = await this.$api("/api/memberIdCheck",{param: this.member.m_id});
            if(result[0].cnt <= 0) {
                return true;
            } else {
                this.$swal.fire({
                    text: '중복된 아이디 입니다',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
                return false;
            }
        },
        validation() {
            let b = true;
            let text = "";

            if(this.member.m_pwd != this.pwdChk) {
                text = "비밀번호를 확인해 주세요"
                this.$refs.pwdChk.focus();
                b = false;
            }

            if(this.member.m_pos.trim() == "") {
                text = "직급을 입력해 주세요";
                this.$refs.pos.focus();
                b = false;
            } else if(this.member.m_id.trim() == "") {
                text = "아이디를 입력해 주세요";
                this.$refs.id.focus();
                b = false;
            } else if(this.member.m_pwd.trim() == "") {
                text = "비밀번호를 입력해 주세요";
                this.$refs.pwd.focus();
                b = false;
            } else if(this.member.m_name.trim() == "") {
                this.$refs.name.focus();
                text = "이름을 입력해 주세요";
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
        }
    }
}
</script>