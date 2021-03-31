<template>
  <div class="container">
    <Header />
        <section id="section">
          <SubHeader title="일일보고" />
          <div class="section_inner">
              <div class="board_container">
                  <div class="table_wrapper">
                      <table class="table notice create">
                            <thead class="desktop">
                                <tr>
                                    <th colspan="1">
                                        제목
                                    </th>
                                    <td colspan="5">
                                        <input v-model="boardDetail.b_title" type="text" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        진행률
                                    </th>
                                    <td colspan="2">
                                        <input v-model="boardDetail.b_prog" type="text" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                    <th colspan="1">
                                        비고
                                    </th>
                                    <td colspan="2">
                                        <input v-model="boardDetail.b_etc" type="text" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                </tr>
                            </thead>
                            <thead class="mobile">
                                <tr>
                                    <th colspan="2">
                                        제목
                                    </th>
                                    <td colspan="4">
                                        <input v-model="boardDetail.b_title" type="text" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2">
                                        진행률
                                    </th>
                                    <td colspan="4">
                                        <input v-model="boardDetail.b_prog" type="text" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2">
                                        비고
                                    </th>
                                    <td colspan="4">
                                        <input v-model="boardDetail.b_etc" type="text" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="6">
                                        <textarea v-model="boardDetail.b_desc" cols="30" rows="10" placeholder="내용을 입력해 주세요"></textarea>
                                    </td>
                                </tr>
                            </tbody>
                      </table>
                      <div class="edit clearfix">
                          <router-link to="/notice">목록</router-link>
                          <a @click="updateBoard()" href="#">수정</a>
                          <a @click="this.$router.go(-2)" href="#">취소</a>
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
        }
    },
    created() {
        this.boardSno = this.$route.query.b_sno;
        this.getBoardDetail();
        this.getBoardFile();
    },
    methods: {
        async getBoardDetail() {
          let boardDetail = await this.$api("/api/boardDetail",{param:[this.typeSno, this.boardSno]});
          if(boardDetail.length > 0) {
            this.boardDetail = boardDetail[0];
          }
          this.$redirect("/department", boardDetail.length == 0);
        },
        async getBoardFile() {
            this.boardFile = await this.$api("/api/boardFile",{param:[this.boardSno]});
        },
        async updateBoard() {
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
                    let param = {
                        b_title: this.boardDetail.b_title,
                        b_desc: this.boardDetail.b_desc,
                        b_prog: this.boardDetail.b_prog,
                        b_etc: this.boardDetail.b_etc
                    };
                    await this.$api("/api/updateBoard",{param:[param, this.boardSno]});
                    this.$router.push({path:'/dayreport'});
                }
            })
        },
        validation() {
            let b = true;
            let text = "";

            if(this.boardDetail.b_title.trim() == "") {
                text = "제목을 입력해 주세요";
                b = false;
            } else if(this.boardDetail.b_desc.trim() == "") {
                text = "내용을 입력해 주세요";
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