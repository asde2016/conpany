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
                                        <input v-model="boardDetail.b_title" type="text" placeholder="제목을 입력해 주세요" autofocus>
                                    </td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="6">
                                        <textarea v-model="boardDetail.b_desc" cols="30" rows="10" placeholder="내용을 입력해 주세요"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                <th colspan="2">첨부파일</th>
                                <td colspan="4">
                                    <div :key="i" v-for="(file,i) in boardFile" class="saved">
                                        <input type="text" readonly :value="file.b_f_name"><a @click="deleteFile($event.target, file.b_f_sno)" href="#">삭제</a>
                                    </div>
                                    <input @change="uploadFile($event.target.files, 0)" type="file" />
                                    <input @change="uploadFile($event.target.files, 1)" type="file" />
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
            typeSno: 1,
            boardDetail: {},
            boardFile: [],
            files: [],
            deleteFiles: []
        }
    },
    created() {
        let user = this.$store.state.user;
        this.$redirect("/", user.m_sno != 0);
        
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
          this.$redirect("/notice", boardDetail.length == 0);
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
                        b_desc: this.boardDetail.b_desc
                    };
                    await this.$api("/api/updateBoard",{param:[param, this.boardSno]});
                    // 기존파일 삭제
                    for(let i = 0; i < this.deleteFiles.length; i++){
                        this.deleteBoardFile(i);
                    }
                    // 새로운 파일 추가
                    for(let i = 0; i < this.files.length; i++){
                        this.insertBoardFile(i);
                    }
                    setTimeout(() => {
                        this.$router.push({path:'/notice'});
                    }, 500);
                }
            })
        },
        async insertBoardFile(index) {
            let name = "";
            let data = null;
            if (this.files[index]) {
                name = this.files[index][0].name;
                data = await this.$base64(this.files[index][0]);
            }
            const { error } = await this.$api(`/upload/${this.boardSno}/${name}`, { data });
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
        async deleteBoardFile(index) {
            let sno = 0;
            if (this.deleteFiles[index]) {
                sno = this.deleteFiles[index];
            }
            await this.$api("/api/deleteBoardFile",{param:[sno]});
        },
        uploadFile(file, index) {
            this.files[index] = file;
        },
        deleteFile(elmnt, bFSno) {
            this.deleteFiles.push(bFSno);
            elmnt.parentNode.remove();
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