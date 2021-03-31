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
                                        <input v-model="board.b_title" type="text" placeholder="제목을 입력해주세요." autofocus>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="1">
                                        진행률
                                    </th>
                                    <td colspan="2">
                                        <input v-model="board.b_prog" type="text" placeholder="진행률을 입력해주세요.">
                                    </td>
                                    <th colspan="1">
                                        비고
                                    </th>
                                    <td colspan="2">
                                        <input v-model="board.b_etc" type="text">
                                    </td>
                                </tr>
                            </thead>
                            <thead class="mobile">
                                <tr>
                                    <th colspan="2">
                                        제목
                                    </th>
                                    <td colspan="4">
                                        <input v-model="board.b_title" type="text" placeholder="제목을 입력해주세요." autofocus>
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2">
                                        진행률
                                    </th>
                                    <td colspan="4">
                                        <input v-model="board.b_prog" type="text" placeholder="진행률을 입력해주세요.">
                                    </td>
                                </tr>
                                <tr>
                                    <th colspan="2">
                                        비고
                                    </th>
                                    <td colspan="4">
                                        <input v-model="board.b_etc" type="text">
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="6">
                                        <textarea v-model="board.b_desc" cols="30" rows="10" placeholder="내용을 입력해 주세요"></textarea>
                                    </td>
                                </tr>
                            </tbody>
                      </table>
                      <div class="edit clearfix">
                          <router-link to="/dayreport">목록</router-link>
                          <a @click="insertBoard()" href="#">등록</a>
                          <a @click="this.$router.go(-1)" href="#">취소</a>
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
            board: {
                d_sno: this.$store.state.user.d_sno,
                t_sno: 3,
                m_sno: this.$store.state.user.m_sno,
                b_title: "",
                b_desc: "",
                b_prog: "",
                b_etc: "",
            }
        };
    },
    created() {
        
    },
    methods: {
        async insertBoard() {
            let vald = this.validation();
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
                    await this.$api("/api/insertBoard",{param:[this.board]});
                    this.$router.push({path:'/dayreport'});
                }
            })
        },
        validation() {
            let b = true;
            let text = "";

            if(this.board.b_title.trim() == "") {
                text = "제목을 입력해 주세요";
                b = false;
            } else if(this.board.b_prog.trim() == "") {
                text = "진행률을 입력해 주세요";
                b = false;
            } else if(this.board.b_desc.trim() == "") {
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