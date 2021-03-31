<template>
  <div class="container">
        <Header />
        <section id="section">
            <SubHeader title="일일보고" />
            <div class="section_inner">
                <div class="board_container">
                    <div class="table_wrapper">
                        <table class="table notice detail">
                            <thead class="desktop">
                                <tr>
                                    <th colspan="6">{{boardDetail.b_title}}</th>
                                </tr>
                                <tr>
                                    <th colspan="1">작성자</th>
                                    <td colspan="2">
                                        <span v-if="boardDetail.m_f_name != null" class="profile" :style="{ background: `url(/download/profile/${boardDetail.m_sno}/${boardDetail.m_f_name}) no-repeat center center`, backgroundSize: 'cover'}"></span>
                                        <span v-else class="profile"><i class="fas fa-user-circle"></i></span>
                                        <span v-if="boardDetail.m_sno != 0">{{boardDetail.m_name}}({{boardDetail.m_pos}})</span>
                                        <span v-else>{{boardDetail.m_name}}</span>
                                    </td>
                                    <th colspan="1">등록일</th>
                                    <td colspan="2">{{boardDetail.reg_date}}</td>
                                </tr>
                                <tr>
                                    <th colspan="1">진행률</th>
                                    <td colspan="2">{{boardDetail.b_prog}}</td>
                                    <th colspan="1">비고</th>
                                    <td colspan="2" class="star">{{boardDetail.b_etc}}</td>
                                </tr>
                            </thead>
                            <thead class="mobile">
                                <tr>
                                    <th colspan="6">{{boardDetail.b_title}}</th>
                                </tr>
                                <tr>
                                    <th colspan="2">작성자</th>
                                    <td colspan="4">
                                        <span v-if="boardDetail.m_f_name != null" class="profile" :style="{ background: `url(/download/profile/${boardDetail.m_sno}/${boardDetail.m_f_name}) no-repeat center center`, backgroundSize: 'cover'}"></span>
                                        <span v-else class="profile"><i class="fas fa-user-circle"></i></span>
                                        <span v-if="boardDetail.m_sno != 0">{{boardDetail.m_name}}({{boardDetail.m_pos}})</span>
                                        <span v-else>{{boardDetail.m_name}}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2">등록일</th>
                                    <td colspan="4">{{boardDetail.reg_date}}</td>
                                </tr>
                                <tr>
                                    <th colspan="2">진행률</th>
                                    <td colspan="4">{{boardDetail.b_prog}}</td>
                                </tr>
                                <tr>
                                    <th colspan="2">비고</th>
                                    <td colspan="4" class="star">{{boardDetail.b_etc}}</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="6">
                                        <div class="desc">
                                            {{boardDetail.b_desc}}
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="edit clearfix">
                            <router-link to="/dayreport" href="#">목록</router-link>
                            <a v-if="boardDetail.m_sno == this.$store.state.user.m_sno || this.$store.state.user.m_sno == 0" @click="deleteBoard()" href="#">삭제</a>
                            <a v-if="boardDetail.m_sno == this.$store.state.user.m_sno || this.$store.state.user.m_sno == 0" @click="goToUpdate()" href="#">수정</a>
                        </div>
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
            boardSno: 0,
            typeSno: 3,
            boardDetail: {},
            boardFile: []
        }
    },
    created() {
      this.boardSno = this.$route.query.b_sno;
      this.getBoardDetail();
      this.getBoardFile();
      this.updateBoardViews();
    },
    methods: {
        async getBoardDetail() {
            let boardDetail = await this.$api("/api/boardDetail",{param:[this.typeSno, this.boardSno]});
            if(boardDetail.length > 0) {
                this.boardDetail = boardDetail[0];
            }
            this.$redirect("/dayreport", boardDetail.length == 0);
        },
        async getBoardFile() {
            this.boardFile = await this.$api("/api/boardFile",{param:[this.boardSno]});
        },
        async updateBoardViews() {
            await this.$api("/api/updateBoardViews",{param:[this.boardSno]});
        },
        goToUpdate() {
            this.$router.push({path:'/dayreport/update', query:{b_sno:this.boardSno}});
        },
        async deleteBoard() {
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
                    await this.$api("/api/deleteBoard",{param:[this.boardSno]});
                    this.$router.push({path:'/dayreport'});
                }
            })
        }
    }
}
</script>