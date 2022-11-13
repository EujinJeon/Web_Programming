<%@ page contentType="text/html; charset=utf-8"%>
<HTML>                                         
<HEAD>                                       
<SCRIPT language="javascript">                              
function check(){                                         
 with(document.msgwrite){                      
  if(subject.value.length == 0){                  
   alert("제목을 입력해 주세요!!");                       
   subject.focus();                           
   return false;                             
  }                                         
  if(name.value.length == 0){                   
   alert("이름을 입력해 주세요!!");                  
   name.focus();                              
   return false;                                  
  }                                         
  if(password.value.length == 0){              
   alert("비밀번호를 입력해 주세요!!");              
   password.focus();                            
   return false;                               
  }                                        
  if(content.value.length == 0){                    
   alert("내용을 입력해주세요!!");                   
   content.focus();                         
   return false;                           
  }                                        
  document.msgwrite.submit();                       
 }                                          
}                                            
</SCRIPT>                                    
<link href="filegb.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="../bootstrap-4.6.0-dist/css/bootstrap.min.css">
</HEAD>                                       
<BODY>
<%
	String table = request.getParameter("table");
	//if (table==null) table = "freeboard";
	String table_name = null;
	if (table.equals("freeboard"))
		table_name = "공지사항";
	else if (table.equals("dataroom"))
		table_name = "서식자료실";
	else if (table.equals("gallery"))
		table_name = "갤러리";
	else if (table.equals("faq"))
		table_name = "자주하는질문";
	else if (table.equals("qna"))
		table_name = "질문하기";	
%>                                      
<div class="container">                                           
  <form name="msgwrite" method="post" action="freeboard_save.jsp?table=<%=table%>" class="form-horizontal">
   <div class="form-group">
       <hr style="border: solid 1px green">                                   
       <h3 class="text-center bg-info" align="center">새글 쓰기</h3>
       <hr style="border: solid 1px green">
   </div>
                                       
  <div class="form-group row">                                       
   <label class="col-2">이름</label>
   <div class="col-6">
     <input type="text" id="name" name="name" class="form-control">  
   </div>
  </div>                                                                             
  <div class="form-group row">                                       
   <label class="col-2">E-mail</label>
    <div class="col-6">
      <input type="text" id = "email" name="email" class="form-control">   
    </div>
   </div>
   
   <div class="form-group row">                                       
   <label class="col-2">제목</label>
    <div class="col-6">
      <input type="text" id="subject" name="subject" class="form-control">   
    </div>
   </div>
   
   <div class="form-group row">                                       
   <label class="col-2">내용</label>
    <div class="col-6">
      <textarea cols="65" rows="10" name=content maxlength="2000" class="textarea_style1"></textarea>   
    </div>
   </div>
   
   <div class="form-group row">                                       
   <label class="col-2">암호</label>
    <div class="col-6">
      <input type="password" id="password" name="password" class="form-control">   
    </div>
   </div>
                                                                                        
 <tr>                                       
  <td colspan="2" height="1" class='button'></td>                                  
 </tr>                                       
 <tr>              
  <td colspan="2" height="1" bgcolor="#1F4F8F"></td>     
 </tr>                                      
 <tr>                                         
  <td colspan="2" height="10"></td>                                    
 </tr>                                          
 <tr>                                          
  <td colspan="2" align="right">                    
   <table width="100%" border="0" cellpadding="0" cellspacing="0">                      
    <tr>                     
     <td width="28%">&nbsp;</td>               
     <td width="51%">&nbsp;</td>                
     <td width="12%"><a href="#" onClick="history.go(-1)"><img src="image/cancle.gif" width="46" height="20" border="0"></td>
     <td width="9%"><a href="#" onClick="check();"><img src="image/ok.gif" width="46" height="20" border="0"></a></td>
    </tr>
   </table>
  </td>
 </tr>                                                                                
</form>
</div>                                        
</BODY>
<script src="../bootstrap-4.6.0-dist/jquery/jquery-3.5.1.js"></script>
<script src="../bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>                                        
</HTML>  