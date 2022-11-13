<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<HTML>
<HEAD><TITLE>게시판</TITLE>
<%@ include file="../../link.txt"%>
<link href="fboard.css" rel="stylesheet" type="text/css">

<SCRIPT language="javascript">
 function check(){
  with(document.msgsearch){
   if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   }	
   document.msgsearch.submit();
  }
 }
 /*
 function rimgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/arrow.gif";
  }

 function imgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/close.gif";
 }
 */
</SCRIPT>

</HEAD>
<BODY>

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
%>
<div class="container">
<%@ include file="../../menu.jsp"%>
<P>
<P align=center><FONT color=#0000ff face=굴림 size=5><STRONG><%=table_name %></STRONG></FONT></P> 
<P>
<CENTER>
 <TABLE class="table">
  <thead>
     <tr class="b-hed" align="center">
      <th scope="col">번호</th>
      <th scope="col" width="300">제목</th>
      <th scope="col">등록자</th>
      <th scope="col">날짜</th>
      <th scope="col">조회</th>
      <td scope="col">감춤</th>
    </tr>
  </thead>

 <% 
  Vector name=new Vector();
  Vector inputdate=new Vector();
  Vector email=new Vector();
  Vector subject=new Vector();
  Vector rcount=new Vector();
  
  Vector step=new Vector();
  Vector keyid=new Vector();
  int where=1;

  int totalgroup=0;
  int maxpages=2;
  int startpage=1;
  int endpage=startpage+maxpages-1;
  int wheregroup=1;

  if (request.getParameter("go") != null) {
   where = Integer.parseInt(request.getParameter("go"));
   wheregroup = (where-1)/maxpages + 1;
   startpage=(wheregroup-1) * maxpages+1;  
   endpage=startpage+maxpages-1; 
  } else if (request.getParameter("gogroup") != null) {
   wheregroup = Integer.parseInt(request.getParameter("gogroup"));
   startpage=(wheregroup-1) * maxpages+1;  
   where = startpage ; 
   endpage=startpage+maxpages-1; 
  }
  int nextgroup=wheregroup+1;
  int priorgroup= wheregroup-1;

  int nextpage=where+1;
  int priorpage = where-1;
  int startrow=0;
  int endrow=0;
  int maxrows=5;
  int totalrows=0;
  int totalpages=0;

  int id=0;

  String em=null;
//  Connection con= null;
  Statement st =null;
  ResultSet rs =null;
 
  
 try {
  st = con.createStatement();
  String sql = "select * from " + table + " order by" ;
  sql = sql + " masterid desc, replynum, step, id" ;
  rs = st.executeQuery(sql);

  if (!(rs.next()))  {
   out.println("게시판에 올린 글이 없습니다");
  } else {
   do {
    keyid.addElement(new Integer(rs.getInt("id")));
    name.addElement(rs.getString("name"));
    email.addElement(rs.getString("email"));
    String idate = rs.getString("inputdate");
    idate = idate.substring(0,8);
    inputdate.addElement(idate);
    subject.addElement(rs.getString("subject"));
    rcount.addElement(new Integer(rs.getInt("readcount")));
    step.addElement(new Integer(rs.getInt("step")));
   }while(rs.next());
   totalrows = name.size();
   totalpages = (totalrows-1)/maxrows +1;
   startrow = (where-1) * maxrows;
   endrow = startrow+maxrows-1  ;
   if (endrow >= totalrows)
    endrow=totalrows-1;
  
   totalgroup = (totalpages-1)/maxpages +1;
   if (endpage > totalpages) 
    endpage=totalpages;

   for(int j=startrow;j<=endrow;j++) {
    String temp=(String)email.elementAt(j);
    if ((temp == null) || (temp.equals("")) ) 
     em= (String)name.elementAt(j); 
    else
     em = "<A href=mailto:" + temp + ">" + name.elementAt(j) + "</A>";

    id= totalrows-j;
    if(j%2 == 0){
     out.println("<TR bgcolor='#FFFFFF' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor=''\">");	
    } else {
     out.println("<TR bgcolor='#F4F4F4' onMouseOver=\" bgColor= '#DFEDFF'\" onMouseOut=\"bgColor='#F4F4F4'\">");
    } 
    out.println("<TD  class=\"b-hed\" align=center>");
    out.println(id+"</TD>");
    out.println("<TD class=\"b-hed\">");
    int stepi= ((Integer)step.elementAt(j)).intValue();
    int imgcount = j-startrow; 
    if (stepi > 0 ) {
     for(int count=0; count < stepi; count++)
      out.print("&nbsp;&nbsp;");
     out.println("<IMG name=icon"+imgcount+ " src=image/arrow.gif>");
     out.print("<A href=freeboard_read.jsp?table="+ table + "&id=");
     out.print(keyid.elementAt(j) + "&page=" + where );
     out.print(" onmouseover=\"rimgchg(" + imgcount + ",1)\"");
     out.print(" onmouseout=\"rimgchg(" + imgcount + ",2)\">");
    } else {
     out.println("<IMG name=icon"+imgcount+ " src=image/close.gif>");
     out.print("<A href=freeboard_read.jsp?table="+ table + "&id=");
     out.print(keyid.elementAt(j) + "&page=" + where );
     out.print(" onmouseover=\"imgchg(" + imgcount + ",1)\"");
     out.print(" onmouseout=\"imgchg(" + imgcount + ",2)\">");
    }
    out.println(subject.elementAt(j) + "</a></TD>");
    out.println("<TD class=\"b-hed\" align=center>");
    out.println(em+ "</TD>");
    out.println("<TD class=\"b-hed\" align=center>");
    out.println(inputdate.elementAt(j)+ "</TD>");
    out.println("<TD class=\"b-hed\" align=center>");
    out.println(rcount.elementAt(j)+ "</TD>");

    
    
// 추가    
    out.println("<td>"); 

    if (stepi > 0 ) {
        for(int count=0; count < stepi; count++)
//         out.print("&nbsp;&nbsp;");
        out.println("<div class=\"container_div\"><IMG name=icon"+imgcount+ " src=image/arrow.gif>");
        out.print("<A href=freeboard_read.jsp?table="+ table + "&id=");
        out.print(keyid.elementAt(j) + "&page=" + where );
        out.print(" onmouseover=\"rimgchg(" + imgcount + ",1)\"");
        out.print(" onmouseout=\"rimgchg(" + imgcount + ",2)\">");
       } else {
        out.println("<div class=\"container_div\"><IMG name=icon"+imgcount+ " src=image/close.gif>");
        out.print("<A href=freeboard_read.jsp?table="+ table + "&id=");
        out.print(keyid.elementAt(j) + "&page=" + where );
        out.print(" onmouseover=\"imgchg(" + imgcount + ",1)\"");
        out.print(" onmouseout=\"imgchg(" + imgcount + ",2)\">");
       }
    out.println(subject.elementAt(j) + "</a>");
    out.println("<div class=\"container_div\" align=\"right\"><small>");
    out.println(em+ "&nbsp;&nbsp; | &nbsp;&nbsp;");
    out.println(inputdate.elementAt(j)+ "&nbsp;&nbsp; | &nbsp;&nbsp;조회수 : ");
    out.println(rcount.elementAt(j)+ "</small></div>");
    out.println("</div>");  
    out.println("</TD>");
//추가 끝    
    
    out.println("</TR>");
   }
   rs.close();
  }
  out.println("</TABLE>");
  st.close();
  con.close();
 } catch (java.sql.SQLException e) {
  out.println(e);
 } 

 if (wheregroup > 1) {
  out.println("[<A href=freeboard_list.jsp?table="+ table + "&gogroup=1>처음</A>]"); 
  out.println("[<A href=freeboard_list.jsp?table="+ table + "&gogroup="+priorgroup +">이전</A>]");
 } else {
  out.println("[처음]") ;
  out.println("[이전]") ;
 }
 if (name.size() !=0) { 
  for(int jj=startpage; jj<=endpage; jj++) {
   if (jj==where) 
    out.println("["+jj+"]") ;
   else
    out.println("[<A href=freeboard_list.jsp?table="+ table + "&go="+jj+">" + jj + "</A>]") ;
   } 
  }
  if (wheregroup < totalgroup) {
   out.println("[<A href=freeboard_list.jsp?table="+ table + "&gogroup="+ nextgroup+ ">다음</A>]");
   out.println("[<A href=freeboard_list.jsp?table="+ table + "&gogroup="+ totalgroup + ">마지막</A>]");
  } else {
   out.println("[다음]");
   out.println("[마지막]");
  }
  out.println ("전체 글수 :"+totalrows); 
 %>
<!--<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right valign=bottom>
   <A href="freeboard_write.htm"><img src="image/write.gif" width="66" height="21" border="0"></A>
   </TD>
  </TR>
 </TABLE>-->
<br><br>
<FORM class="form-inline" method="post" name="msgsearch" action="freeboard_search.jsp?table=<%=table %>">

<div class="container">
 	<div class="row form-group">
   		<SELECT class="col form-control offset-md-7" name="stype" >
    		<OPTION value=1 >이름
    		<OPTION value=2 >제목
    		<OPTION value=3 >내용
    		<OPTION value=4 >이름+제목
    		<OPTION value=5 >이름+내용
    		<OPTION value=6 >제목+내용
    		<OPTION value=7 >이름+제목+내용
   		</SELECT>
   		&nbsp;
   		<INPUT class="col form-control" type=text  name="sval" placeholder="내용입력하세요"> 
   		&nbsp;
   		<a href="#" onClick="check();"><button type="button" class="btn btn-success">검색</button></a>
   		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   	</div>
	<br>
	<div align=right><A href="freeboard_write.jsp?table=<%=table%>"><img src="image/write.gif" class="img-fluid"></A></div>
</div>

</FORM>
</TABLE>
</CENTER>
</div>
<div class = "container">
<%@ include file="../../footer.jsp"%>
</div>
</BODY>
</HTML>