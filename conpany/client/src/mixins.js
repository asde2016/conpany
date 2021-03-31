import axios from 'axios';

export default {
    methods: {
        async $api(url, data) {
            return (await axios({
                method: 'post',
                url,
                data
            }).catch(e => {
                console.log(e);
            })).data;
        },
        $base64(file) {
            return new Promise(resolve => {
                var a = new FileReader();
                a.onload = e => resolve(e.target.result);
                a.readAsDataURL(file);
            });
        },
        $redirect(path, bool) {
            if(bool){
                this.$router.push({path:path});
                this.$swal({
                        text: "잘못된 접급입니다",
                        icon: 'warning',
                        confirmButtonText: '확인',
                    });
            } 
        }
    }
}