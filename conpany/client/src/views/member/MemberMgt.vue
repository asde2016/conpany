<template>
    <div class="container">
        <Header />
        <section id="section">
            <SubHeader title="계정관리"/>
            <div class="section_inner">
                <div class="board_container">
                    <div class="title clearfix">
                        <div class="text">
                            <p>전체 <span>{{memberList.length}}</span> 건</p>
                            <p><span>{{curPage}}/{{totalPage}}</span> 페이지</p>
                        </div>
                        <div class="form">
                            <div class="select_wrapper">
                                <select v-model="searchType">
                                    <option :value="0">이름</option>
                                    <option :value="1">부서</option>
                                    <option :value="2">직급</option>
                                </select>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <input v-model="searchName" ref="search" type="search" placeholder="검색어를 입력하세요">
                            <input @click="goSearch()" type="button" value="검색">
                        </div>
                    </div>
                    <div class="table_wrapper">
                        <nav id="sub_nav">
                            <ul>
                                <li><router-link to="/member/info">회원정보 변경</router-link></li>
                                <li><router-link to="/member/pwd">비밀번호 변경</router-link></li>
                                <li v-if="this.$store.state.user.m_sno == 0" class="active"><router-link to="/member/mgt">회원관리</router-link></li>
                            </ul>
                        </nav>
                        <table class="table list admin">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>부서</th>
                                    <th>직급</th>
                                    <th>이름</th>
                                    <th>아이디</th>
                                    <th>주소</th>
                                    <th>이메일</th>
                                    <th>휴대폰 번호</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr @click="goUpdate(member.m_sno)" :key="i" v-for="(member,i) in memberListInPage">
                                    <td>{{member.m_sno}}</td>
                                    <td>{{member.d_name}}</td>
                                    <td>{{member.m_pos}}</td>
                                    <td>{{member.m_name}}</td>
                                    <td>{{member.m_id}}</td>
                                    <td>{{member.m_address}}</td>
                                    <td>{{member.m_email}}</td>
                                    <td>{{member.m_phone}}</td>
                                    <td><input @click="deleteMember(member.m_sno)" @click.stop="tr" type="button" value="삭제"></td>
                                </tr>
                            </tbody>
                        </table>
                        <div v-if="memberListInPage.length == 0" class="none">
                            <p>사원이 없습니다</p>
                        </div>
                        <div class="edit clearfix">
                            <router-link to="/member/create">추가</router-link>
                        </div>
                        <nav id="pagination"> 
                            <ul>
                                <li :class="pagePrev"><a @click="goFirstPage" class="btn_first" href="#">first</a></li>
                                <li :class="pagePrev"><a @click="goPrevPage" class="btn_prev" href="#">prev</a></li>
                                <li :class="pageActive(page)" :key="i" v-for="(page,i) in pageNation"><a @click="goPage(page)" href="#">{{page}}</a></li>
                                <li :class="pageNext"><a @click="goNextPage" class="btn_next" href="#">next</a></li>
                                <li :class="pageNext"><a @click="goLastPage" class="btn_last" href="#">last</a></li>
                            </ul>
                        </nav>
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
            memberList: [],
            perPage: 10,
            pageCnt: 5,
            curPage: 1,
            totalPage: 1,
            searchName: "",
            searchType: 0,
            id: "",
            oldPwd: "",
            newPwd: "",
            pwdChk: ""
        }
    },
    created() {
        let user = this.$store.state.user;
        this.$redirect("/", user.m_sno != 0);
        
        this.id = this.$store.state.user.m_id;
        this.getMemberList();
        this.getPageData();
    },
    updated() {
        this.$store.commit("pageData", {
                path: this.$route.path,
                type: this.searchType,
                name: this.searchName,
                page: this.curPage
            });
    },
    computed: {
        memberListInPage() {
            let list = this.memberList.filter(member => 
                       member.rownum >= (this.curPage - 1) * this.perPage + 1
                    && member.rownum <= this.curPage * this.perPage);

            return list;
        },
        pageNation() {
            let page = [];
            let start = (Math.floor(this.curPage / (this.pageCnt + 1)) * this.pageCnt) + 1;
            for(let i = start; i < start + this.pageCnt; i++){
                if(i <= this.totalPage) {
                    page.push(i);
                }
            }
            return page;
        },
        pagePrev() {
            return this.curPage > 1 ? "on" : "";
        },
        pageNext() {
            return this.curPage < this.totalPage ? "on" : "";
        }
    },
    methods: {
        async getMemberList() {
            this.memberList = await this.$api("/api/memberList");
            this.totalPage = Math.floor(this.memberList.length / this.perPage) > 0
                           ? Math.floor(this.memberList.length / this.perPage) + 1
                           : 1;
        },
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
        goUpdate(mSno) {
            this.$router.push({path:'/member/update', query: {m_sno: mSno}});
        },
        pageActive(pageNum) {
            return this.curPage == pageNum ? "active" : "";
        },
        goPage(pageNum) {
            this.curPage = pageNum;
        },
        goFirstPage() {
            this.curPage = 1;
        },
        goLastPage() {
            this.curPage = this.totalPage;
        },
        goPrevPage() {
            this.curPage > 1 ? this.curPage-- : 1;
        },
        goNextPage() {
            this.curPage < this.totalPage ? this.curPage++ : this.curPage;
        },
        async goSearch() {
            let searchName = this.searchName.replace(/ +/g, " ");
            let vald = this.validation(this.searchName);
            if(!vald) return;
            let path = "/api/memberListByName";
            switch(this.searchType) {
                case 1:
                    path = "/api/memberListByDept";
                    break;
                case 2:
                    path = "/api/memberListByPos";
                    break;
            }
            this.memberList = await this.$api(path,{param: searchName});
            this.curPage = 1;
            this.totalPage = Math.floor(this.memberList.length / this.perPage) > 0
                           ? Math.floor(this.memberList.length / this.perPage) + 1
                           : 1;
        },
        async deleteMember(mSno) {
            this.$swal.fire({
                title: '정말 삭제 하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#e35454',
                confirmButtonText: '삭제',
                cancelButtonColor: '#333',
                cancelButtonText: '취소',
                iconColor: '#e35454'
            }).then(async (result) => {
                if (result.isConfirmed) {
                    this.$swal.fire({
                        title: '삭제!',
                        text: '삭제가 완료 됐습니다',
                        icon: 'success',
                        confirmButtonText: '확인',
                    });
                    await this.$api("/api/deleteMember",{param:[mSno]});
                    this.memberList = this.getMemberList();
                }
            })
        },
        getPageData() {
            let pageData = this.$store.state.pageData;
            let length = Object.keys(pageData).length;
            if(length > 0) {
                this.searchType = pageData.type;
                this.searchName = pageData.name;
                this.curPage = pageData.page;
                if(pageData.name.trim() != ""){
                    this.goSearch(pageData.page);
                }
            }
        },
        validation(searchName) {
            let b = true;
            let title = "";

            if(searchName == "") {
                title = "검색어를 입력해 주세요";
                this.$refs.search.focus();
                b = false;
            } else {
                if(searchName.length < 2) {
                    title = "검색어는 2글자 이상만 가능합니다.";
                    this.$refs.search.focus();
                    b = false;
                }
            }

            if(!b) {
                this.$swal({
                    text: title,
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
            }
            return b;
        }
    }
}
</script>