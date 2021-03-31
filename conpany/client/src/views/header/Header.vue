<template>
  <header id="header">
        <div class="header_inner">
            <div class="logo">
                <h1><router-link to="/main"><img src="@/assets/images/logo.png" alt="logo"></router-link></h1>
            </div>
            <nav id="desktop">
                <ul>
                    <li :class="this.$route.path.includes('main') ? 'active' : ''">
                        <router-link to="/main"><i class="fas fa-home"></i>메인</router-link>
                    </li>
                    <li :class="this.$route.path.includes('notice') ? 'active' : ''">
                        <router-link to="/notice"><i class="fas fa-clipboard-list"></i>공지사항</router-link>
                    </li>
                    <li :class="this.$route.path.includes('department') ? 'active' : ''">
                        <router-link to="/department"><i class="fas fa-users"></i>부서</router-link>
                    </li>
                    <li :class="this.$route.path.includes('dayreport') ? 'active' : ''">
                        <router-link to="/dayreport"><i class="fas fa-sticky-note"></i>일일보고</router-link>
                    </li>
                    <li :class="this.$route.path.includes('share') ? 'active' : ''">
                        <router-link to="/share"><i class="fas fa-cloud"></i>공유폴더</router-link>
                    </li>
                    <li :class="this.$route.path.includes('private') ? 'active' : ''">
                        <router-link to="/private"><i class="fas fa-folder-open"></i>개인폴더</router-link>
                    </li>
                </ul>
            </nav>
            <nav id="mobile">
                <ul>
                    <li :class="this.$route.path.includes('main') ? 'active' : ''">
                        <router-link to="/main"><i class="fas fa-home"></i></router-link>
                    </li>
                    <li :class="this.$route.path.includes('notice') ? 'active' : ''">
                        <router-link to="/notice"><i class="fas fa-clipboard-list"></i></router-link>
                    </li>
                    <li :class="this.$route.path.includes('department') ? 'active' : ''">
                        <router-link to="/department"><i class="fas fa-users"></i></router-link>
                    </li>
                    <li :class="this.$route.path.includes('dayreport') ? 'active' : ''">
                        <router-link to="/dayreport"><i class="fas fa-sticky-note"></i></router-link>
                    </li>
                    <li :class="this.$route.path.includes('share') ? 'active' : ''">
                        <router-link to="/share"><i class="fas fa-cloud"></i></router-link>
                    </li>
                    <li :class="this.$route.path.includes('private') ? 'active' : ''">
                        <router-link to="/private"><i class="fas fa-folder-open"></i></router-link>
                    </li>
                </ul>
            </nav>
        </div>
    </header>
</template>

<script>
export default {
    created() {
        let user = this.$store.state.user;
        let length = Object.keys(user).length;
        this.$redirect("/", length == 0);
    }
}
</script>