<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*,java.util.*" %> 

<HTML>
<HEAD><TITLE>글 읽기</TITLE>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="../bootstrap-4.6.0-dist/css/bootstrap.min.css">
<link href="fboard.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>

<%@ include file="dbconn.jsp" %>
<%
 String sql=null;
// Connection con= null;
 PreparedStatement st =null;
 ResultSet rs =null;

 int id = Integer.parseInt(request.getParameter("id"));
 String table = request.getParameter("table");
 
 try {
  sql = "select * from " + table + " where id=? ";
  st = con.prepareStatement(sql);
  st.setInt(1, id);
  rs = st.executeQuery();
 
  if (!(rs.next()))  {
   out.println("해당 내용이 없습니다");
  } else {
   String em=rs.getString("email");
   if ((em != null) && (!(em.equals(""))) ) 
    em = "<A href=mailto:" +em + ">" + rs.getString("name")+"</A>";
   else
    em = rs.getString("name");
   out.println("<CENTER>");
   out.println("<table class='table'>");
   	out.println("<thead>");
   		out.println("<tr>");
  		 out.println("<th colspan=\"2\" scope=\"col\">제목 :" +rs.getString("subject")+ "</th>");
   		out.println("</tr>");
   	out.println("</thead>");
   	out.println("<tboard>");
   		out.println("<tr>");
   			out.println("<td colspan=\"2\" scope=\"row\">글쓴이 : "+ em +"</td>");
   		out.println("</tr>");
   		out.println("<tr>");
   			out.println("<td scope=\"row\">작성일 : " + rs.getString("inputdate") + "</td>");
   			out.println("<td scope=\"row\">조회 : "+rs.getInt("readcount")+"</td>");
   		out.println("</tr>");
   		out.println("<tr>");
   			out.println("<td colspan=\"2\" scope=\"row\">"+rs.getString("content").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") + "</td>");
   		out.println("</tr>");
   		out.println("<tr>");
   			out.println("<td colspan=\"2\" scope=\"row\"></td>");
   		out.println("</tr>");
   	out.println("</tbody>");
   out.println("</table>");
  %>
  <div class="container" style="disaplay:inline-block; text-align:center;">
    
    <A href="freeboard_list.jsp?go=<%=request.getParameter("page")%>&table=<%=table%>"> 
     <img src="image/list.jpg" border=0></a>
	<A href="freeboard_rwrite.jsp?id=<%= request.getParameter("id")%>&page=<%=request.getParameter("page")%>&table=<%=table%>"> <img src="image/reply.jpg" border=0></A>
	<A href="freeboard_upd.jsp?id=<%=id%>&page=1&table=<%=table%>"><img src="image/edit.jpg" border=0></A>
	<A href="freeboard_del.jsp?id=<%=id%>&page=1&table=<%=table%>"><img src="image/del.jpg"  border=0></A>
   
  </div>
  <%    
   sql = "update freeboard set readcount= readcount + 1 where id= ?" ;
   st = con.prepareStatement(sql);
   st.setInt(1, id);
   st.executeUpdate();
  }
  rs.close();
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