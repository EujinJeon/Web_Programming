<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<HTML>
<HEAD>
<SCRIPT language="javascript">
function check(){
 with(document.msgrewrite){
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
  document.msgrewrite.submit();
 }
}
</SCRIPT> 
<link href="filegb.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="../bootstrap-4.6.0-dist/css/bootstrap.min.css">
</HEAD>
<BODY>
<%@ include file="dbconn.jsp" %>

<P>

<%
 String sql=null;
// Connection con= null;
 Statement st =null;
 ResultSet rs =null;
 int pos=0;
 String sub=null;
 String cont=null;
 int step=0;
 int rnum=0;
 int mid=0;
 int id = Integer.parseInt(request.getParameter("id"));
 String table = request.getParameter("table");
 
 
 try {
  sql = "select * from " + table + " where id="+id ;
  st = con.createStatement();
  rs = st.executeQuery(sql);
  if (!(rs.next()))  {
   out.println("해당 내용이 없습니다");
  } else {
   cont = ">" + rs.getString("content") ;
   while ((pos=cont.indexOf("\n", pos)) != -1) {
    String left=cont.substring(0, pos+1);
    String right=cont.substring(pos+1, cont.length());
    cont = left + ">" + right;
    pos += 2;
   }
   sub = "Re:" + rs.getString("subject");
   step = rs.getInt("step");
   mid = rs.getInt("masterid");                                     
   rnum = rs.getInt("replynum");                             
  %>
  <div class="container">
  <form name='msgrewrite' method="post" action="freeboard_rsave.jsp?id=<%=id%>&page=<%=request.getParameter("page")%>&table=<%=table%>" class="form-horizontal">
   <div class="form-group">
   	<hr style="border : solid 1px green">
   	<h3 class="text-center bg-info">글 답변하기</h3>
   	<hr style= "border:solid 1px green">
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
      <input type="text" id="subject" name="subject" class="form-control" value="<%=sub%>" >    
    </div>
   </div>
   
   <div class="form-group row">                                       
   <label class="col-2">내용</label>
    <div class="col-6">
   <textarea cols="65" rows="10" name=content maxlength="2000" class="textarea_style1">

-----------------------------------------------------------------------
<%=cont%></textarea>
</div>
   </div>
   <div class="form-group row">                                       
   <label class="col-2">암호</label>
    <div class="col-6">
      <input type="password" id="password" name="password" class="form-control">(정확한 비밀번호를 입력해야만 수정이 됩니다.)   
    </div>
   </div>
   <div class="form_group">
   <hr style="border : solid 1px green">
   </div>
   <div class="form-group row">
   <div class="col-12" style="display:inline-block; text-align:center;">
   <a href="#" onClick="check();"><img src="image/ok.gif" class="img-fluid"></a>
   <a href="#" onClick="history.go(-1)"><img src="image/cancle.gif" border="0"></a>
   <A href="freeboard_list.jsp?go=<%=request.getParameter("page")%>&table=<%=table%>"> <img src="image/list.jpg" border=0></a>
   </div>
   </div>
   <INPUT type="hidden" name="step" value="<%=step%>">
   <INPUT type="hidden" name="mid" value="<%=mid%>">
   <INPUT type="hidden" name="rnum" value="<%=rnum%>">
  </form>
  </div>
<%
  }
  st.close();
  con.close();
 } catch (SQLException e) {
  out.println(e);
 }
%>
</BODY>
<script src="../bootstrap-4.6.0-dist/jquery/jquery-3.5.1.js"></script>
<script src="../bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js"></script>
</HTML>