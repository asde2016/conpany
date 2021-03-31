<template>
    <div class="container">
        <Header />
        <section id="section">
            <SubHeader title="일일보고"/>
            <div class="section_inner">
                <div class="board_container">
                    <div class="title clearfix">
                        <div class="text">
                            <p>전체 <span>{{boardList.length}}</span> 건</p>
                            <p><span>{{curPage}}/{{totalPage}}</span> 페이지</p>
                        </div>
                        <div class="form">
                            <div class="select_wrapper">
                                <select v-model="searchType">
                                    <option :value="0">제목+내용</option>
                                    <option :value="1">제목</option>
                                    <option :value="2">내용</option>
                                    <option :value="3">작성자</option>
                                </select>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <input v-model="searchName" type="search" placeholder="검색어를 입력하세요">
                            <input @click="goSearch()" type="button" value="검색">
                        </div>
                    </div>
                    <div class="table_wrapper">
                        <table class="table dayreport list">
                            <thead>
                              <tr>
                                <th colspan="1">번호</th>
                                <th colspan="4">제목</th>
                                <th colspan="4">내용</th>
                                <th colspan="2">작성자</th>
                                <th colspan="2">진행률</th>
                                <th colspan="2">비고</th>
                                <th colspan="2">등록일</th>
                              </tr>
                            </thead>
                            <tbody>
                                <tr @click="goToDetail(board.b_sno)" :key="i" v-for="(board,i) in boardListInPage">
                                    <td colspan="1">{{board.index}}</td>
                                    <td colspan="4">
                                        <a v-if="board.new !== 0" href="#"><span class="new">NEW</span>{{board.b_title}}</a>
                                        <a v-else @click="goToDetail(board.b_sno)" href="#">{{board.b_title}}</a>
                                    </td>
                                    <td colspan="4">
                                        <a href="#">{{board.b_desc}}</a>
                                    </td>
                                    <td colspan="2">
                                        <span v-if="board.m_f_name !== null" class="profile" :style="{ background: `url(/download/profile/${board.m_sno}/${board.m_f_name}) no-repeat center center`, backgroundSize: 'cover'}"></span>
                                        <span v-else class="profile"><i class="fas fa-user-circle"></i></span>
                                        <span v-if="board.m_sno !== 0">{{board.m_name}}({{board.m_pos}})</span>
                                        <span v-else>{{board.m_name}}</span>
                                    </td>
                                    <td colspan="2">{{board.b_prog}}</td>
                                    <td colspan="2" class="star">{{board.b_etc}}</td>
                                    <td colspan="2">{{board.reg_date}}</td>
                                </tr>
                            </tbody>
                        </table>
                        <div v-if="boardListInPage.length == 0" class="none">
                            <p>게시물이 없습니다</p>
                        </div>
                        <div class="edit clearfix">
                            <router-link v-if="this.$store.state.user != null" to="/dayreport/create" href="#">글작성</router-link>
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
import Header from '../../header/Header.vue'
import SubHeader from '../../header/SubHeader.vue'
export default {
    components: {
        Header,
        SubHeader
    },
    data() {
        return {
            boardList: [],
            departmentList: [],
            typeSno: 3,
            perPage: 10,
            pageCnt: 5,
            curPage: 1,
            totalPage: 1,
            searchName: "",
            searchType: 0,
        }
    },
    created() {
        this.getBoardList();
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
        boardListInPage() {
            let list = this.boardList.filter(board => 
                       board.rownum >= (this.curPage - 1) * this.perPage + 1
                    && board.rownum <= this.curPage * this.perPage);

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
        async getBoardList() {
            this.departmentList = await this.$api("/api/departmentList");
            this.boardList = await this.$api("/api/boardList",{param:[this.typeSno, this.setIncludeDepartment()]});
            this.totalPage = Math.floor(this.boardList.length / this.perPage) + 1;
        },
        setIncludeDepartment(){
            let dSno = "";
            for(let i = 0; i < this.departmentList.length; i++){
                dSno += this.departmentList[i].d_sno + "|";
            }

            return dSno;
        },
        goToDetail(b_sno) {
            this.$router.push({path: '/dayreport/detail', query:{b_sno: b_sno}});
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
        async goSearch(){
            let searchName = this.searchName.replace(/ +/g, " ");
            let vald = this.validation(this.searchName);
            let path = "/api/boardListByTitleAndDesc";
            let param = [this.typeSno, this.$store.state.user.d_sno, searchName, searchName];
            if(!vald) return;
            switch(this.searchType) {
                case 1:
                    path = "/api/boardListByTitle";
                    break;
                case 2:
                    path = "/api/boardListByDesc";
                    break;
                case 3:
                    path = "/api/boardListByWriter";
                    break;
            }
            this.boardList = await this.$api(path,{param:param});
            this.curPage = 1;
            this.totalPage = Math.floor(this.boardList.length / this.perPage) + 1;
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
                b = false;
            } else {
                if(searchName.length < 2) {
                    title = "검색어는 2글자 이상만 가능합니다.";
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