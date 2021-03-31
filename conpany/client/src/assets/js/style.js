$(function(){
    // common
    $("a[href='#']").click(function(e){
        e.preventDefault();
    });
    $("body").contextmenu( function() {
        return false;    
    });
    // if($('#summernote')[0] != null){
    //     $('#summernote').summernote();
    // }

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
        var alarm = $(".dropdown .far.fa-bell")[0];
        var profile = $(".dropdown span")[0];
        var upload = $(".btn_upload")[0];
        var folderContainer = $(".folder_container")[0];
        var folderWrapper = $(".folder_wrapper")[0];
        var fileWrapper = $(".file_wrapper")[0];
        var target = e.target;

        if(target != alarm && target != profile
           && target != upload && target != folderContainer
           && target != folderWrapper && target != fileWrapper){
            $(".dropbox").removeClass("active");
        }
    });

    // 폴더 상단 dropdown 버튼 클릭 이벤트
    $(".btn_upload").click(function(){
        var dropBox = $("body > .dropbox");
        var smDropBox = $(".side_menu .dropbox");
        var left = $(this).offset().left;
        var top = $(this).offset().top + $(this).height() + 10;

        smDropBox.removeClass("active");
        hasActive(dropBox, left, top);
    });

    // 폴더영역 버튼 클릭 이벤트
    $(".folder_container").on("mousedown", function(e){
       if(e.which == 3) {
            var dropBox = $("body > .dropbox");
            var smDropBox = $(".side_menu .dropbox");
            var left = e.pageX;
            var top = e.pageY;

            smDropBox.removeClass("active");
            hasActive(dropBox, left, top);
        } else {
            $(".dropbox").removeClass("active");
        }
    });

    // header 클릭 이벤트
    $("#desktop ul li, #mobile ul li").click(function(){
        var index = $(this).index();
        $("#desktop ul li").removeClass("active");
        $("#mobile ul li").removeClass("active");
        $("#desktop ul li").eq(index).addClass("active");
        $("#mobile ul li").eq(index).addClass("active");
    });

    function hasActive(elmnt, left, top) {
        if(elmnt.hasClass("active")){
            elmnt.removeClass("active");
        } else {
            elmnt.addClass("active");
            elmnt.css({left: left, top: top});
        }
    }

    // 파일 업로드 관련
    var fileTarget = $('.filebox .upload-hidden');
    fileTarget.on('change', function(){
        var filename = "";
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

        // 추출한 파일명 삽입
        $(this).siblings('.upload-name').val(filename);
    });
});