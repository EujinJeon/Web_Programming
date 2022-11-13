<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>학사안내 > 교육과정 게시판목록 | Al소프트웨어학과</title>
<%@ include file="../link.txt"%>
<link rel="stylesheet" type="text/css" href="/JspProject/project/_res/knu/aisw/css/top-of-curriculum.content350a.css" />
</head>
<body class=" aisw-site pc temp08">
<div class="container">
<%@ include file="../menu.jsp"%>
</div>
<div class="container">					
	<p class="h2 font-weight-bold">교육과정</p>
	<br>
							
	<div class="curriculum-top-box">
  		<div>
    		<p>좀 더 자세한 교육과정은 KNU 교육과정 사이트에 <br>상세하게 나와있습니다.</p><a href="https://curriculum.kangwon.ac.kr/" target="_blank" title="새창열림"><span>KNU 교육과정 바로가기</span></a>
    	</div>
	</div>
</div>
<%@ include file="freeboard_list.jsp"%>

<%@ include file="../footer.jsp"%>

</body>
</html>