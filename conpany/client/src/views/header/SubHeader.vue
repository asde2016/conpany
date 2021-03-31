<template>
    <div class="wrapper">
        <div class="title">
            <h2>{{title}}</h2>
        </div>
        <div class="side_menu">
            <ul>
                <li>
                    <a class="dropdown" href="#"><i class="far fa-bell"></i></a><span v-if="alarmList.length > 0">{{alarmList.length}}</span>
                    <div class="dropbox alarm">
                        <span>알림</span>
                        <ul>
                            <li :key="i" v-for="(alarm, i) in alarmList" :class="alarm.dlt_yn === 'n' ? 'active' : ''">
                                <a @click="updateAlarm(alarm)" href="#">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <p>{{alarm.t_name}}<span>{{alarm.reg_date}}</span></p>
                                    <p>{{alarm.b_title}}</p>
                                </a>
                            </li>
                            <li v-if="alarmList.length === 0">
                                알림이 없습니다
                            </li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a class="dropdown" href="#">
                        <span v-if="this.$store.state.user.m_f_name != null" class="profile" :style="{ background: `url(/download/profile/${this.$store.state.user.m_sno}/${this.$store.state.user.m_f_name}) no-repeat center center`, backgroundSize: 'cover'}"></span>
                        <span v-else><i class="fas fa-user-circle"></i></span>
                    </a>
                    <div class="dropbox login">
                        <ul>
                            <li>
                                <a href="#">
                                    <span>{{this.$store.state.user.m_name}}({{this.$store.state.user.m_pos}})</span>
                                </a>
                            </li>
                            <li><a @click="goMember()" href="#">계정관리</a></li>
                            <li><a @click="logout()" href="#">로그아웃</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
import $ from 'jquery'
export default {
    props: {
        title: String
    },
    data() {
        return {
            alarmList: {},
        }
    },
    mounted() {
        $("body").contextmenu( function() {
            return false;    
        });

        // 파일 업로드 관련
        var fileTarget = $('.filebox .upload-hidden');
        fileTarget.on('change', function(){
            var filename = "파일선택";
            if($(this)[0].files[0] != null) {
                // 값이 변경되면
                if(window.FileReader){ // modern browser
                    if (!$(this)[0].files[0].type.match(/image\//)){
                        alert("이미지만 업로드가 가능합니다.");
                        return;   
                    }
                    filename = $(this)[0].files[0].name;
                } else { // old IE
                    filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
                }
            }
            // 추출한 파일명 삽입
            $(this).siblings('.upload-name').val(filename);
        });
        

        // section title 우측 아이콘(알림, 로그인) 클릭 이벤트
        $(".dropdown").click(function(){
            var dropBox = $(this).siblings(".dropbox");
            
            if(dropBox.hasClass("active")){
                dropBox.removeClass("active");
            } else {
                $(".dropbox").removeClass("active");
                dropBox.addClass("active");
            }
        });

        // section title 우측 아이콘 활성화후 다른곳 클릭시 active 삭제
        $("body").on("mousedown", function(e){
            var folderContainer = $(".folder_container")[0];
            var folderWrapper = $(".folder_wrapper")[0];
            var fileWrapper = $(".file_wrapper")[0];
            var target = e.target;

            if(($(target).is("div") || $(target).is("section"))
            && target != folderContainer && target != folderWrapper
            && target != fileWrapper) {
                $(".dropbox").removeClass("active");
            }
        });
    },
    created() {
        this.getAlarmList();
    },
    methods: {
        async getAlarmList() {
            this.alarmList = await this.$api("/api/alarmList",{param:[this.$store.state.user.m_id]});
        },
        async updateAlarm(alarm) {
            await this.$api("/api/updateAlarm",{param:[alarm.a_sno]});
            let path = ""
            if(alarm.t_sno == 1) {
                path = "/notice/detail"
            } else if(alarm.t_sno == 2) {
                path = "/department/detail"
            } 
            this.$router.push({path: path, query:{b_sno: alarm.b_sno}});
        },
        logout() {
            this.$store.commit("user", {});
            this.$store.commit("pwdChk", false);
            this.$router.push({path:"/"});
            this.$swal.fire({
                title: '로그아웃!',
                text: '로그아웃 했습니다',
                icon: 'success',
                confirmButtonText: '확인',
            });
        },
        goMember() {
            this.$router.push({path: '/member/check'});
        }
    }
}
</script>