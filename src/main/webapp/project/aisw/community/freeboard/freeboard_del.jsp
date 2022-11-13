<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" import="java.io.*,java.sql.*,java.util.*" %> 
<HTML>
<HEAD>
<SCRIPT language="javascript">
function check(){
 with(document.msgdel){		
  if(password.value.length == 0){
   alert("비밀번호를 입력해 주세요!!");
   password.focus();
   return false;
  }	
  document.msgdel.submit();
 }
}
</SCRIPT> 
<link href="filegb.css" rel="stylesheet" type="text/css">
<%@ include file="../../link.txt"%>
</HEAD>
<BODY>
<div class="container">
<%@ include file="../../menu.jsp"%>
</div>
<%
	String table = request.getParameter("table");	
%>
<div class="container">
<FORM name="msgdel" method=post action=freeboard_deldb.jsp?table=<%=table%>>
 <input type="hidden" name="id" value="<%=request.getParameter("id")%>"  >
 <input type="hidden" name="page" value="<%=request.getParameter("page")%>"  >
 <div class="form-group">
       <hr style="border: solid 1px green">                                   
       <h3 class="text-center bg-info" align="center">삭제하기</h3>
       <hr style="border: solid 1px green">
  </div>                        
  <div class="form-group row">                                       
   <label class="col-2">암호</label>
    <div class="col-10">
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
    <table width="100%" border="0" cellpadding="4" cellspacing="4">        
     <tr>                                                          
      <td width="84%">&nbsp;</td>                                             
      <td width="8%"><a href="freeboard_list.jsp?go=<%=request.getParameter("page")%>&table=<%=table%> "><img src="image/list.jpg" width="48" height="19" border="0"></a></td>
      <td width="8%"><a href="#" onClick="check();"><img src="image/del.jpg" width="46" height="19" border="0"></a></td>
	 </tr>                                                      
    </table>                                                      
   </td>                                                          
  </tr>                                                            
 </table>   
</form>
</div>
</center>
<%@ include file="../../footer.jsp"%>
</BODY>
</HTML>