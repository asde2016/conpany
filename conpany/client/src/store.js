import {
    createStore
} from 'vuex'

import persistedstate from 'vuex-persistedstate';

const store = createStore({
state() {
    return {
        user: {},
        pwdChk: false,
        pageData: {}
    }
},
mutations: {
    user(state, data) {
        state.user = data;
    },
    pwdChk(state, data) {
        state.pwdChk = data;
    },
    pageData(state, data) {
        state.pageData = data;
    },
},
plugins: [
    persistedstate({
        paths: ['user', 'pwdChk', 'pageData']
    })
]
});

export default store;