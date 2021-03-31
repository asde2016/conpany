<template>
  <div class="container">
        <Header />
        <section id="section">
            <SubHeader title="메인" />
            <div class="section_inner clearfix">
                <div class="content">
                    <div class="title">
                        <div class="wrapper clearfix">
                            <div class="text">
                                <h3>공지사항</h3>
                            </div>
                            <div class="btn">
                                <router-link to="/notice">more</router-link>
                            </div>
                        </div>
                    </div>
                    <div class="desc">
                        <ul>
                            <li :key="i" v-for="(board, i) in noticeList">
                                <router-link :to="'/notice/detail?b_sno=' + board.b_sno">
                                    <div class="wrapper"><span v-if="board.new !== 0" class="new">NEW</span>{{board.b_title}}</div>
                                    <span>{{board.reg_date}}</span>
                                </router-link>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="content">
                    <div class="title">
                        <div class="wrapper clearfix">
                            <div class="text">
                                <h3>{{this.$store.state.user.d_name}}</h3>
                            </div>
                            <div class="btn">
                                <router-link to="/department">more</router-link>
                            </div>
                        </div>
                    </div>
                    <div class="desc">
                        <ul>
                            <li :key="i" v-for="(board, i) in departmentList">
                                <router-link v-if="i < 6" :to="'/department/detail?b_sno=' + board.b_sno">
                                    <div class="wrapper"><span v-if="board.new !== 0" class="new">NEW</span>{{board.b_title}}</div>
                                    <span>{{board.reg_date}}</span>
                                </router-link>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="content">
                    <div class="title">
                        <div class="wrapper clearfix">
                            <div class="text">
                                <h3>일일보고</h3>
                            </div>
                            <div class="btn">                                                
                                <router-link to="/dayreport">more</router-link>
                            </div>
                        </div>
                    </div>
                    <div class="desc">
                        <ul>
                            <li :key="i" v-for="(board, i) in dayreportList">
                                <router-link :to="'/dayreport/detail?b_sno=' + board.b_sno">
                                    <div class="wrapper">
                                        <span v-if="board.m_f_name !== null" class="profile" :style="{ background: `url(/download/profile/${board.m_sno}/${board.m_f_name}) no-repeat center center`, backgroundSize: 'cover'}"></span>
                                        <span v-else class="profile"><i class="fas fa-user-circle"></i></span>
                                        {{board.b_title}}
                                    </div>
                                    <span>{{board.reg_date}}</span>
                                </router-link>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="content folder">
                    <div class="title">
                        <div class="wrapper clearfix">
                            <div class="text">
                                <h3>공유폴더</h3>
                            </div>
                            <div class="btn">                                                
                                <router-link to="/share">more</router-link>
                            </div>
                        </div>
                    </div>
                    <div class="desc">
                        <ul>
                            <li :key="i" v-for="(folder, i) in shareList"><a @click="goFolder('ShareList', folder.f_sno, folder.f_title)" href="#"><i class="fas fa-folder"></i><span>{{folder.f_title}}</span></a></li>
                        </ul>
                    </div>
                </div>
                <div class="content folder">
                    <div class="title">
                        <div class="wrapper clearfix">
                            <div class="text">
                                <h3>개인폴더</h3>
                            </div>
                            <div class="btn">                                                
                                <router-link to="/private">more</router-link>
                            </div>
                        </div>
                    </div>
                    <div class="desc">
                        <ul>
                            <li :key="i" v-for="(folder, i) in privateList"><router-link to="#"><i class="fas fa-folder"></i><span>{{folder.f_title}}</span></router-link></li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import Header from './header/Header.vue'
import SubHeader from './header/SubHeader.vue'
export default {
    components: {
        Header,
        SubHeader,
    },
    data() {
        return {
            boardList: [],
            folderList: []
        }
    },
    created() {
        this.getBoardList();
        this.getFolderList();
    },
    computed: {
        noticeList() {
            let list = this.boardList.filter(board => 
                       board.t_sno == 1);

            list.splice(6);

            return list;
        },
        departmentList() {
            let mSno = 0; 
            if(this.$store.state.user != 0) mSno = this.$store.state.user.m_sno;

            let list = this.boardList.filter(board => 
                       board.t_sno == 2);

            if(mSno != 0) {
                list = list.filter(board => 
                       board.d_sno == this.$store.state.user.d_sno);
            }

            list.splice(6);

            return list;
        },
        dayreportList() {
            let list = this.boardList.filter(board =>
                       board.t_sno == 3);

            list.splice(4);

            return list;
        },
        shareList() {
            let list = this.folderList.filter(folder => 
                       folder.f_t_no == 2);
                       
            list.splice(10);

            return list;
        },
        privateList() {
            let list = this.folderList.filter(folder => 
                       folder.f_t_no == 1
                    && folder.m_sno == this.$store.state.user.m_sno);

            list.splice(10);

            return list;
        }
    },
    methods: {
        async getBoardList() {
            this.boardList = await this.$api("/api/boardListAll");
        },
        async getFolderList() {
            this.folderList = await this.$api("/api/folderListAll");
        },
        goFolder(name, fSno, fFTitle) {
            this.$router.push({name: name, params: {f_sno: fSno, f_title: fFTitle}});
        }
    }
}
</script>
