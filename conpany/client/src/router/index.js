import { createRouter, createWebHistory } from 'vue-router'

// 로그인
import Login from '../views/Login.vue'
// 메인
import Main from '../views/Main.vue'
// 공지사항
import NoticeList from '../views/board/notice/NoticeList.vue'
import NoticeDetail from '../views/board/notice/NoticeDetail.vue'
import NoticeCreate from '../views/board/notice/NoticeCreate.vue'
import NoticeUpdate from '../views/board/notice/NoticeUpdate.vue'
// 부서
import DepartmentList from '../views/board/department/DepartmentList.vue'
import DepartmentDetail from '../views/board/department/DepartmentDetail.vue'
import DepartmentCreate from '../views/board/department/DepartmentCreate.vue'
import DepartmentUpdate from '../views/board/department/DepartmentUpdate.vue'
// 일일보고
import DayreportList from '../views/board/dayreport/DayreportList.vue'
import DayreportDetail from '../views/board/dayreport/DayreportDetail.vue'
import DayreportCreate from '../views/board/dayreport/DayreportCreate.vue'
import DayreportUpdate from '../views/board/dayreport/DayreportUpdate.vue'
// 폴더
import FolderList from '../views/folder/FolderList.vue'
// 계정관리
import MemberMgtChk from '../views/member/MemberMgtChk.vue'
import MemberInfoMgt from '../views/member/MemberInfoMgt.vue'
import MemberPwdMgt from '../views/member/MemberPwdMgt.vue'
import MemberMgt from '../views/member/MemberMgt.vue'
import MemberCreate from '../views/member/MemberCreate.vue'
import MemberUpdate from '../views/member/MemberUpdate.vue'

const routes = [
  {
    path: '/',
    name: 'Login',
    component: Login
  },
  {
    path: '/main',
    name: 'Main',
    component: Main
  },
  {
    path: '/notice',
    name: 'NoticeList',
    component: NoticeList
  },
  {
    path: '/notice/detail',
    name: 'NoticeDetail',
    component: NoticeDetail
  },
  {
    path: '/notice/create',
    name: 'NoticeCreate',
    component: NoticeCreate
  },
  {
    path: '/notice/update',
    name: 'NoticeUpdate',
    component: NoticeUpdate
  },
  {
    path: '/department',
    name: 'DepartmentList',
    component: DepartmentList
  },
  {
    path: '/department/detail',
    name: 'DepartmentDetail',
    component: DepartmentDetail
  },
  {
    path: '/department/create',
    name: 'DepartmentCreate',
    component: DepartmentCreate
  },
  {
    path: '/department/update',
    name: 'DepartmentUpdate',
    component: DepartmentUpdate
  },
  {
    path: '/dayreport',
    name: 'DayreportList',
    component: DayreportList
  },
  {
    path: '/dayreport/detail',
    name: 'DayreportDetail',
    component: DayreportDetail
  },
  {
    path: '/dayreport/create',
    name: 'DayreportCreate',
    component: DayreportCreate
  },
  {
    path: '/dayreport/update',
    name: 'DayreportUpdate',
    component: DayreportUpdate
  },
  {
    path: '/private',
    name: 'PrivateList',
    component: FolderList
  },
  {
    path: '/share',
    name: 'ShareList',
    component: FolderList
  },
  {
    path: '/member/check',
    name: 'MemberMgtChk',
    component: MemberMgtChk
  },
  {
    path: '/member/info',
    name: 'MemberInfoMgt',
    component: MemberInfoMgt
  },
  {
    path: '/member/pwd',
    name: 'MemberPwdMgt',
    component: MemberPwdMgt
  },
  {
    path: '/member/mgt',
    name: 'MemberMgt',
    component: MemberMgt
  },
  {
    path: '/member/create',
    name: 'MemberCreate',
    component: MemberCreate
  },
  {
    path: '/member/update',
    name: 'MemberUpdate',
    component: MemberUpdate
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
