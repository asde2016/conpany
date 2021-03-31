<template>
    <div class="container">
        <Header />
        <section id="section">
            <SubHeader :title="title"/>
            <div class="section_inner">
                <div class="board_container">
                    <div class="title clearfix">
                        <div class="text">
                            <div class="dropdown_wrapper">
                                <ul>
                                    <li><a @click="goFolder(0, null, null)" class="btn_upload" href="#">공유폴더</a></li>
                                    <li :key="i" v-for="(nav, i) in folderNav"><i class="fas fa-caret-right"></i><a @click="goFolder(nav.sno, nav.title, i)" href="#">{{nav.title}}</a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- <div class="form folder_search">
                            <input type="search" placeholder="검색어를 입력하세요">
                            <input type="button" value="검색">
                        </div> -->
                    </div>
                    <div @mousedown="dropBox" class="folder_container">
                        <div class="title">
                            <h3>폴더</h3>
                        </div>
                        <div class="folder_wrapper clearfix">
                            <div @mousedown="selectFile(1, folder.f_sno)" :key="i" v-for="(folder, i) in folderList" class="folder">
                                <a @click="goFolder(folder.f_sno, folder.f_title)" href="#">
                                    <span><i class="fas fa-folder"></i>{{folder.f_title}}</span>
                                </a>
                            </div>
                        </div>
                        <div v-if="folderSno != 0" class="title">
                            <h3>파일</h3>
                        </div>
                        <div v-if="folderSno != 0" class="file_wrapper clearfix">
                            <div @mousedown="selectFile(2, file.f_sno)" :key="i" v-for="(file, i) in folderFileList" class="file">
                                <a :href="'/download/folder/' + this.folderSno + '/' + file.f_f_name">
                                    <span>
                                        <i :class="getExtension(file.f_f_name)"></i>
                                        {{file.f_f_name}}
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="dropbox" ref="dropbox">
            <ul v-if="dropBoxType == 1">
                <li>
                    <a @click="this.$refs.dropbox.classList.remove('active')" class="add_folder" href="#">
                        <i class="fas fa-folder-plus"></i>새 폴더
                    </a>
                </li>
                <li>
                    <a href="">
                        <label @click="fileInsertCheck" for="input-file"><i class="fas fa-file-medical"></i>파일 업로드</label>
                        <input @change="uploadFile($event.target.files, 0)" ref="file" id="input-file" type="file" class="folder_file" hidden>
                    </a>
                </li>
            </ul>
            <ul v-else-if="dropBoxType == 2">
                <li>
                    <a @click="deleteElmnt" href="#">
                        <i class="fas fa-trash-alt"></i>삭제
                    </a>
                </li>
            </ul>
        </div>
        <div class="folderbox" ref="folderbox">
            <div class="top">
                <h3>새 폴더</h3>
            </div>
            <div class="middle">
                <input ref="folder_title" type="text" placeholder="제목을 입력해 주세요">
            </div>
            <div class="bottom">
                <a @click="newFolder" href="#">만들기</a>
                <a class="cancel" ref="cancel" href="#">취소</a>
            </div>
            <a class="cancel" href="#"><i class="fas fa-times"></i></a>
        </div>
        <div class="dim"></div>
    </div>
</template>

<script>
import $ from 'jquery'
import Header from '../header/Header.vue'
import SubHeader from '../header/SubHeader.vue'
export default {
    components: {
        Header,
        SubHeader
    },
    data() {
        return {
            title: "",
            folderSno: 0,
            folderList: [],
            folderFileList: [],
            folderNav: [],
            files: [],
            dropBoxType: 1,
            selectElmntType: 0,
            selectElmntSno: 0,
        }
    },
    created() {
        if(this.getFolderTypeNo() == 1) this.title = "개인폴더";
        else if(this.getFolderTypeNo() == 2) this.title = "공유폴더";

        this.getPageData();
        this.getFolderList();
    },
    updated() {
        this.$store.commit("pageData", {
                path: this.$route.path,
                sno: this.folderSno,
                nav: this.folderNav,
            });
    },
    mounted() {
        $(".add_folder, .cancel, .dim").click(() => {
            var folderBox = $(".container > .folderbox");
            if(folderBox.hasClass("active")) {
                folderBox.removeClass("active");
                folderBox.fadeOut(300);
                $(".dim").fadeOut(300);
                setTimeout(() => {
                    this.$refs.folder_title.value = "";
                }, 300);
            } else {
                folderBox.addClass("active");
                folderBox.fadeIn(300);
                $(".dim").fadeIn(300);
            }
        });
    },
    methods: {
        async getFolderList() {
            let fTNo = this.getFolderTypeNo();
            let path = "";
            if(fTNo == 1) {
                path += "ByMember";
            }
            this.folderList = await this.$api("/api/folderList" + path,{param:[this.folderSno, fTNo, this.$store.state.user.m_sno]});
            this.folderFileList = await this.$api("/api/folderFileList" + path,{param:[this.folderSno, fTNo, this.$store.state.user.m_sno]});
        },
        getFolderTypeNo(){
            let fTNo = 0;
            if(this.$route.path.includes('private')){
                fTNo = 1;
            } else if(this.$route.path.includes('share')) {
                fTNo = 2;
            }
            return  fTNo;
        },
        goFolder(fSno, fFTitle, index = -1){
            this.folderSno = fSno;
            this.getFolderList();
            let item = {sno: fSno, title: fFTitle};
            if(index == null) {
                this.folderNav = [];
            } else if(index < 0) {
                this.folderNav.push(item);
            } else {
                for(let i = this.folderNav.length - 1; i > index; i--){
                    this.folderNav.pop(this.folderNav[i]);
                }
            }
        },
        async insertFolderFile() {
            for(let i = 0; i < this.files.length; i++){
                this.uploadFolderFile(i);
            }
        },
        uploadFile(file, index){
            this.files[index] = file;
            this.insertFolderFile();
            setTimeout(() => {
                this.folderList = this.getFolderList();
            }, 1000);
        },
        async uploadFolderFile(index) {
            let name = "";
            let data = null;
            if (this.files[index]) {
                name = this.files[index][0].name;
                data = await this.$base64(this.files[index][0]);
            }
            const { error } = await this.$api(`/folder/${this.folderSno}/${name}`, { data });
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
        async newFolder() {
            let vald = this.validation();
            if(!vald) return;

            let fTNo = this.getFolderTypeNo();
            let param = {
                p_f_sno : this.folderSno,
                m_sno: this.$store.state.user.m_sno,
                f_t_no: fTNo,
                f_title: this.$refs.folder_title.value
            }
            await this.$api("/api/insertFolder",{param: param});

            setTimeout(() => {
                this.folderList = this.getFolderList();
            }, 1000);
            this.$refs.cancel.click();
        },
        fileInsertCheck(e) {
            if(this.folderSno == 0) {
                e.preventDefault();
                this.$swal.fire({
                    title: '실패!',
                    text: '현재폴더에서는 파일을 업로드 할 수 없습니다',
                    icon: 'warning',
                    confirmButtonText: '확인',
                });
            }
            this.$refs.dropbox.classList.remove('active');
        },
        dropBox(e) {
            let target = $(e.target);
            
            if(e.which == 3) {
                var dropBox = $(".container > .dropbox");
                var smDropBox = $(".side_menu .dropbox");
                var left = e.pageX;
                var top = e.pageY;

                smDropBox.removeClass("active");
                
                if(dropBox.hasClass("active")){
                    dropBox.removeClass("active");
                } else {
                    if(target.is("i") || target.is("a") || target.is("span")) {
                        this.dropBoxType = 2;
                    } else {
                        this.dropBoxType = 1;
                    }
                    dropBox.addClass("active");
                    dropBox.css({left: left, top: top});
                }
            } else {
                $(".dropbox").removeClass("active");
            }
        },
        selectFile(type, fSno) {
            this.selectElmntType = type;
            this.selectElmntSno = fSno;
        },
        async deleteElmnt() {
            this.$refs.dropbox.classList.remove('active');
            if(this.selectElmntType == 1){
                await this.$api("/api/deleteFolder",{param: this.selectElmntSno});
            } else if(this.selectElmntType == 2) {
                await this.$api("/api/deleteFolderFile",{param: this.selectElmntSno});
            }

            setTimeout(() => {
                this.folderList = this.getFolderList();
            }, 1000);
        },
        getExtension(name) {
            let className = "";
            name = name.split('.')[name.split('.').length - 1];
            if(name == "xlsx" || name == "xlsm" || name == "xlsb" || name == "xltx"
            || name == "xltxm" || name == "xls" || name == "xlt" || name == "xls" || name == "xlam") {
                className = "fas fa-file-excel";
            } else if(name == "hwp" || name == "hwt" || name == "doc" || name == "docx"){
                className = "fas fa-file-word";
            } else if(name == "avi" || name == "mp4" || name == "mkv" || name == "wmv"
                   || name == "mov"){
                className = "fas fa-file-video";
            } else if(name == "pptx" || name == "pptm" || name == "ppt"){
                className = "fas fa-file-powerpoint";
            } else if(name == "pdf") {
                className = "fas fa-file-pdf";
            } else if(name == "bmp" || name == "jpeg" || name == "jpg" || name == "gif"
                   || name == "png" || name == "tiff"){
                className = "fas fa-file-image";
            } else if(name == "mp3" || name == "wav" || name == "aiff" || name == "gif"
                   || name == "png" || name == "tiff"){
                className = "fas fa-file-audio";
            } else if(name == "html" || name == "xml" || name == "js" || name == "css"
                   || name == "jsp" || name == "vue" || name == "react"){
                className = "fas fa-file-code";
            } else if(name == "zip" || name == "gz" || name == "rar" || name == "tgz"
                   || name == "tar"){
                className = "fas fa-file-archive";
            } else {
                className = "fas fa-file-alt";
            }
            return className;
        },
        getPageData() {
            let params = this.$route.params;
            let length = Object.keys(params).length;
            if(length > 0) {
                this.goFolder(params.f_sno, params.f_title);
            }
            
            let pageData = this.$store.state.pageData;
            length = Object.keys(pageData).length;
            if(length > 0) {
                this.folderSno = pageData.sno;
                this.folderNav = pageData.nav;
            }
        },
        validation() {
            let b = true;
            let text = "";
            if(this.$refs.folder_title.value.trim() == "") {
                text = "제목을 입력해 주세요";
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