<template>
<!-- <router-view :key="$route.fullPath"/> -->
<router-view :key="$route.fullPath"/>
</template>

<style>
@import './assets/css/reset.css';
@import './assets/css/style.css';
</style>

<script>
export default {
watch: {
    // 페이지 이동시 저장된 검색내용 삭제
    $route(to, from) {
        if(to.path != from.path) {
            let pageData = this.$store.state.pageData;
            let length = Object.keys(pageData).length;
            if(length != 0 && to.path != pageData.path) {
                this.$store.commit("pageData", {});
            }
        }
    }
}
}
</script>

