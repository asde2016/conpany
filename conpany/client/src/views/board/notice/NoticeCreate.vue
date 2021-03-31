<template>
  <div class="container">
    <Header />
        <section id="section">
          <SubHeader title="공지사항" />
          <div class="section_inner">
              <div class="board_container">
                  <div class="table_wrapper">
                      <table class="table notice create">
                            <thead>
                                <tr>
                                    <th colspan="2">
                                        제목
                                    </th>
                                    <td colspan="4">
                                        <input v-model="board.b_title" type="text" name="" id="" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="6">
                                        <textarea v-model="board.b_desc" cols="30" rows="10" placeholder="내용을 입력해 주세요"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                <th colspan="2">첨부파일</th>
                                <td colspan="4">
                                    <input @change="uploadFile($event.target.files, 0)" type="file" />
                                    <input @change="uploadFile($event.target.files, 1)" type="file" />
                                </td>
                            </tr>
                            </tbody>
                      </table>
                      <div class="edit clearfix">
                          <router-link to="/notice">목록</router-link>
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
                t_sno: 1,
                m_sno: this.$store.state.user.m_sno,
                b_title: "",
                b_desc: "",
                b_prog: "",
                b_etc: "",
            },
            files: []
        };
    },
    created() {
        let user = this.$store.state.user;
        this.$redirect("/", user.m_sno != 0);
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
                    let lastBoardSno = await this.$api("/api/lastBoardSno");
                    this.insertAlarm(lastBoardSno);
                    for(let i = 0; i < this.files.length; i++){
                        this.insertBoardFile(i, lastBoardSno);
                    }
                    this.$router.push({path:'/notice'});
                }
            })
        },
        async insertBoardFile(index, lastBoardSno) {
            
            let name = "";
            let data = null;
            if (this.files[index]) {
                name = this.files[index][0].name;
                data = await this.$base64(this.files[index][0]);
            }
            const { error } = await this.$api(`/upload/${lastBoardSno[0].b_sno}/${name}`, { data });
            if (error) {
                this.$swal.fire({
                    title: '실패!',
                    text: '파일 업로드를 실패했습니다',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
                return;
            }
        },
        async insertAlarm(lastBoardSno) {
            await this.$api("/api/insertAlarmAll",{param:[lastBoardSno[0].b_sno, this.$store.state.user.m_id]});
        },
        uploadFile(file, index) {
            this.files[index] = file;
        },
        validation() {
            let b = true;
            let text = "";

            if(this.board.b_title.trim() == "") {
                text = "제목을 입력해 주세요";
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