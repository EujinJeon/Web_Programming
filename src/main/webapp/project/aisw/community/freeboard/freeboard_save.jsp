<%@ page contentType="text/html; charset=utf-8"%>  
<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file="dbconn.jsp" %>
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
 String na = request.getParameter("name");
 String em = request.getParameter("email");
 String sub = request.getParameter("subject"); 
 String cont = request.getParameter("content");
 String pw = request.getParameter("password");
 int id =1;
 int pos=0;
 if (cont.length()==1) 
  cont = cont+" "  ;

 while ((pos=cont.indexOf("\'", pos)) != -1) {
  String left=cont.substring(0, pos);
  String right=cont.substring(pos, cont.length());
  cont = left + "\'" + right;
  pos += 2;
 }

 java.util.Date yymmdd = new java.util.Date() ;
 SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-dd h:mm a");
 String ymd=myformat.format(yymmdd);

 String sql=null;
// Connection con=null;
 Statement st=null; 
 ResultSet rs=null;  
 int cnt=0; 


try{
  st = con.createStatement();
  sql = "select max(id) from " + table;
  rs = st.executeQuery(sql);
  if (!(rs.next())) 
   id=1;
  else {
   id= rs.getInt(1) + 1 ;
   rs.close();
  }       
  sql= "insert into "+ table +" (id,name,password,email,subject," ;
  sql= sql + "content,inputdate,masterid,readcount,replynum,step)" ; 
  sql= sql + " values(" +id + ", '" +  na + "','" + pw + "','"+ em  ;
  sql= sql + "','" + sub + "','" + cont + "','" + ymd + "'," +id+"," ;
  sql= sql + "0,0,0)";

  cnt = st.executeUpdate(sql); 
 // if (cnt >0) 
 //  out.println("데이터가 성공적으로 입력되었습니다.");
 // else  
 //  out.println("데이터가 입력되지 않았습니다. ");
  
  st.close();
  con.close();
 } catch (SQLException e) {
  out.println(e);
 }
%>
<jsp:forward page="freeboard_list.jsp" />