module.exports = {
     //#region member
     memberList : {
          query: `select row_number() over (order by tm.m_sno asc) as 'rownum',
                         tm.*, td.d_name
                    from t_member tm
                         join t_department td on tm.d_sno = td.d_sno
                   where m_sno != 0 and tm.dlt_yn = 'n'`
     },
     memberListByName : {
          query: `select row_number() over (order by tm.m_sno asc) as 'rownum',
                         tm.*, td.d_name
                    from t_member tm
                         join t_department td on tm.d_sno = td.d_sno
                   where m_sno != 0 and tm.dlt_yn = 'n' and m_name regexp ?`
     },
     memberListByDept : {
          query: `select row_number() over (order by tm.m_sno asc) as 'rownum',
                         tm.*, td.d_name
                    from t_member tm
                         join t_department td on tm.d_sno = td.d_sno
                   where m_sno != 0 and tm.dlt_yn = 'n' and d_name regexp ?`
     },
     memberListByPos : {
          query: `select row_number() over (order by tm.m_sno asc) as 'rownum',
                         tm.*, td.d_name
                    from t_member tm
                         join t_department td on tm.d_sno = td.d_sno
                   where m_sno != 0 and tm.dlt_yn = 'n' and m_pos regexp ?`
     },
     memberFile : {
          query: `select tmf.m.f_sno, tmf.m_f_name
                    from t_member tm
                         join t_member_file tmf on tm.m_sno = tmf.m_sno
                   where tm.m_sno = ? and tm.dlt_yn = 'n'`
     },
     memberDetail : {
          query: `select m_id, m_pwd, m_pos, m_email, m_name,
                         m_age, m_phone, m_address, d_sno
                    from t_member
                   where m_sno = ? and dlt_yn = 'n'`
     },
     selectMember : {
          query: `select tm.*, td.d_name, count(1) as 'cnt', tmf.m_f_name
                  from t_member tm
                       join t_department td on tm.d_sno = td.d_sno
                       left join t_member_file tmf on tm.m_sno = tmf.m_sno
                  where tm.m_sno = ? and tm.dlt_yn = 'n'`
     },
     insertMember : {
          query: `insert into t_member set ?`
     },
     updateMember : {
          query: `update t_member set ?, mod_date = now()
                   where m_sno = ?`
     },
     updatePwd : {
          query: `update t_member set m_pwd = ?, mod_date = now()
                   where m_id = ?`
     },
     deleteMember : {
          query: `update t_member set dlt_yn = 'y'
                   where m_sno = ?`
     },
     memberIdCheck : {
          query: `select count(1) as 'cnt'
                    from t_member
                   where m_id = ?`
     },
     insertMemberFile: {
          query: `insert into t_member_file set ? on duplicate key update ?`
     },
     //#endregion member

     //#region alarm
     alarmList: {
          query: `select ta.a_sno, tb.b_sno, tt.t_name, tt.t_sno, tb.b_title,
                         date_format(ta.reg_date, '%m-%d %H:%i') as reg_date, ta.dlt_yn
                    from t_alarm ta
                         join t_board tb on tb.b_sno = ta.b_sno
                         join t_type tt on tt.t_sno = tb.t_sno
                   where m_id = ? and (ta.dlt_date > date_add(now(), interval -3 day) or ta.dlt_yn = 'n')
                         and tb.dlt_yn = 'n'
                order by ta.a_sno desc`
     },
     insertAlarmAll: {
          query: `insert into t_alarm(m_id, b_sno)
                  select tm.m_id, ?
                    from t_member tm
                   where dlt_yn = 'n' and m_id != ?;`
     },
     insertAlarm: {
          query: `insert into t_alarm(m_id, b_sno)
                  select tm.m_id, ?
                    from t_member tm
                   where dlt_yn = 'n' and m_id != ? and d_sno = ? and m_id != 'admin';`
     },
     updateAlarm: {
          query: `update t_alarm
                     set dlt_yn = 'y', dlt_date = now()
                   where a_sno = ?`
     },
     //#endregion alarm

     //#region board
     boardListAll : {
          query: `select row_number() over (order by tb.b_sno desc) as 'rownum',
                         tb.b_sno, tb.b_title, tb.b_desc, tb.b_prog, tb.b_views,
                         tb.b_etc, date_format(tb.reg_date, '%Y-%m-%d') as reg_date,
                         tb.m_sno, tt.t_name, tm.m_name, tm.m_pos,
                         tmf.m_f_name, tb.t_sno, tb.d_sno,
                         if(date(tb.reg_date) > date_add(now(), interval -1 day), 1, 0) as new,
                         (select count(1) from t_board_file tbf where tb.b_sno = tbf.b_sno) as board_file_cnt
                    from t_board tb
                         join t_type tt on tb.t_sno = tt.t_sno
                         join t_member tm on tb.m_sno = tm.m_sno
                         left join t_member_file tmf on tb.m_sno = tmf.m_sno
                   where tb.dlt_yn = 'n'
                order by tb.b_sno desc`
     },
     boardList : {
          query: `select row_number() over (order by tb.b_sno desc) as 'rownum',
                         row_number() over (order by tb.b_sno) as 'index',
                         tb.b_sno, tb.b_title, tb.b_desc, tb.b_prog, tb.b_views,
                         tb.b_etc, date_format(tb.reg_date, '%Y-%m-%d') as reg_date,
                         tb.m_sno, tt.t_name, tm.m_name, tm.m_pos,
                         tmf.m_f_name,
                         if(date(tb.reg_date) > date_add(now(), interval -1 day), 1, 0) as new,
                         (select count(1) from t_board_file tbf where tb.b_sno = tbf.b_sno) as board_file_cnt
                    from t_board tb
                         join t_type tt on tb.t_sno = tt.t_sno
                         join t_member tm on tb.m_sno = tm.m_sno
                         left join t_member_file tmf on tb.m_sno = tmf.m_sno
                   where tb.t_sno = ? and tb.d_sno regexp ? and tb.dlt_yn = 'n'
                order by tb.b_sno desc`
     },
     boardListByTitleAndDesc : {
          query: `select row_number() over (order by tb.b_sno desc) rownum,
                         row_number() over (order by tb.b_sno) as 'index',
                         tb.b_sno, tb.b_title, tb.b_desc, tb.b_prog, tb.b_views,
                         tb.b_etc, date_format(tb.reg_date, '%Y-%m-%d') as reg_date,
                         tb.m_sno, tt.t_name, tm.m_name, tm.m_pos,
                         tmf.m_f_name,
                         if(date(tb.reg_date) > date_add(now(), interval -1 day), 1, 0) as new,
                         (select count(1) from t_board_file tbf where tb.b_sno = tbf.b_sno) as board_file_cnt
                    from t_board tb
                    join t_type tt on tb.t_sno = tt.t_sno
                    join t_member tm on tb.m_sno = tm.m_sno
               left join t_member_file tmf on tb.m_sno = tmf.m_sno
                   where tb.t_sno = ? and tb.d_sno = ? and (tb.b_title regexp ? or tb.b_desc regexp ?) and tb.dlt_yn = 'n'
                order by tb.b_sno desc`
     },
     boardListByTitle : {
          query: `select row_number() over (order by tb.b_sno desc) rownum,
                         row_number() over (order by tb.b_sno) as 'index',
                         tb.b_sno, tb.b_title, tb.b_desc, tb.b_prog, tb.b_views,
                         tb.b_etc, date_format(tb.reg_date, '%Y-%m-%d') as reg_date,
                         tb.m_sno, tt.t_name, tm.m_name, tm.m_pos,
                         tmf.m_f_name,
                         if(date(tb.reg_date) > date_add(now(), interval -1 day), 1, 0) as new,
                         (select count(1) from t_board_file tbf where tb.b_sno = tbf.b_sno) as board_file_cnt
                    from t_board tb
                    join t_type tt on tb.t_sno = tt.t_sno
                    join t_member tm on tb.m_sno = tm.m_sno
               left join t_member_file tmf on tb.m_sno = tmf.m_sno
                   where tb.t_sno = ? and tb.d_sno = ? and tb.b_title regexp ? and tb.dlt_yn = 'n'
                order by tb.b_sno desc`
     },
     boardListByDesc : {
          query: `select row_number() over (order by tb.b_sno desc) rownum,
                         row_number() over (order by tb.b_sno) as 'index',
                         tb.b_sno, tb.b_title, tb.b_desc, tb.b_prog, tb.b_views,
                         tb.b_etc, date_format(tb.reg_date, '%Y-%m-%d') as reg_date,
                         tb.m_sno, tt.t_name, tm.m_name, tm.m_pos,
                         tmf.m_f_name,
                         if(date(tb.reg_date) > date_add(now(), interval -1 day), 1, 0) as new,
                         (select count(1) from t_board_file tbf where tb.b_sno = tbf.b_sno) as board_file_cnt
                    from t_board tb
                    join t_type tt on tb.t_sno = tt.t_sno
                    join t_member tm on tb.m_sno = tm.m_sno
               left join t_member_file tmf on tb.m_sno = tmf.m_sno
                   where tb.t_sno = ? and tb.d_sno = ? and tb.b_desc regexp ? and tb.dlt_yn = 'n'
                order by tb.b_sno desc`
     },
     boardListByWriter : {
          query: `select row_number() over (order by tb.b_sno desc) rownum,
                         row_number() over (order by tb.b_sno) as 'index',
                         tb.b_sno, tb.b_title, tb.b_desc, tb.b_prog, tb.b_views,
                         tb.b_etc, date_format(tb.reg_date, '%Y-%m-%d') as reg_date,
                         tb.m_sno, tt.t_name, tm.m_name, tm.m_pos,
                         tmf.m_f_name,
                         if(date(tb.reg_date) > date_add(now(), interval -1 day), 1, 0) as new,
                         (select count(1) from t_board_file tbf where tb.b_sno = tbf.b_sno) as board_file_cnt
                    from t_board tb
                    join t_type tt on tb.t_sno = tt.t_sno
                    join t_member tm on tb.m_sno = tm.m_sno
               left join t_member_file tmf on tb.m_sno = tmf.m_sno
                   where tb.t_sno = ? and tb.d_sno = ? and tm.m_name regexp ? and tb.dlt_yn = 'n'
                order by tb.b_sno desc`
     },
     boardDetail : {
          query: `select tb.b_sno, tb.b_title, tb.b_desc, tb.b_prog,
                         tb.b_etc, date_format(tb.reg_date, '%Y-%m-%d') as reg_date,
                         tb.m_sno, tt.t_name, tm.m_name, tm.m_pos,
                         tmf.m_f_name
                    from t_board tb
                         join t_type tt on tb.t_sno = tt.t_sno
                         join t_member tm on tb.m_sno = tm.m_sno
                         left join t_member_file tmf on tb.m_sno = tmf.m_sno
                    where tb.t_sno = ? and tb.b_sno = ? and tb.dlt_yn = 'n'`
     },
     boardFile: {
          query: `select b_f_sno, b_f_name
                  from t_board_file
                  where b_sno = ?`
     },
     insertBoard: {
          query: `insert into t_board set ?`
     },
     updateBoard: {
          query: `update t_board set ?, mod_date = now()
                   where b_sno = ?`
     },
     insertBoardFile: {
          query: `insert into t_board_file set ?`
     },
     updateBoardViews: {
          query: `update t_board set b_views = b_views + 1
                   where b_sno = ?`
     },
     deleteBoard: {
          query: `update t_board set dlt_yn = 'y', dlt_date = now()
                   where b_sno = ?`
     },
     deleteBoardFile: {
          query: `delete from t_board_file where b_f_sno = ?`
     },
     lastBoardSno: {
               query: `select if(b_sno is null, 0, b_sno) as b_sno
                         from t_board
                     order by b_sno desc limit 1`
     },
     //#endregion board

     //#region department
     departmentList : {
          query: `select d_sno, d_name
                    from t_department`
     },
     //#endregion department

     //#region folder
     folderList : {
          query: `select *
                    from t_folder
                   where p_f_sno = ? and f_t_no = ? and dlt_yn = 'n'`
     },
     folderListAll : {
          query: `select *
                    from t_folder
                   where p_f_sno = 0 and dlt_yn = 'n'`
     },
     folderFileList : {
          query: `select tff.*, tf.f_sno, tf.m_sno
                    from t_folder_file tff
                         join t_folder tf on tff.f_sno = tf.f_sno
                   where tf.f_sno = ? and tf.f_t_no = ? and tf.dlt_yn = 'n'`
     },
     folderListByMember : {
          query: `select *
                    from t_folder
                   where p_f_sno = ? and f_t_no = ? and m_sno = ? and dlt_yn = 'n'`
     },
     folderFileListByMember : {
          query: `select tff.*, tf.f_sno, tf.m_sno
                    from t_folder_file tff
                         left join t_folder tf on tff.f_sno = tf.f_sno
                   where tf.f_sno = ? and tf.f_t_no = ? and m_sno = ? and tf.dlt_yn = 'n'`
     },
     insertFolder: {
          query: `insert into t_folder set ?`
     },
     insertFolderFile: {
          query: `insert into t_folder_file set ?`
     },
     deleteFolder: {
          query: `update t_folder set dlt_yn = 'y' where f_sno = ?`
     },
     deleteFolderFile: {
          query: `delete from t_folder_file where f_sno = ?`
     },
     //#endregion folder

     //#region login
     loginCheck: {
          query: `select tm.m_sno, tm.m_id, tm.m_pos, tm.m_email, tm.m_phone, tm.m_address,
                         tm.d_sno, tm.m_name, td.d_name, count(1) as 'cnt', tmf.m_f_name
                  from t_member tm
                       join t_department td on tm.d_sno = td.d_sno
                       left join t_member_file tmf on tm.m_sno = tmf.m_sno
                  where m_id = ? and m_pwd = ?`
     }
     //#endregion login

}