<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*" %> 

<link href="fboard.css" rel="stylesheet" type="text/css">
<link defer rel="stylesheet" type="text/css" href="/JspProject/project/_res/_common/css/cms.css" />
<link rel="stylesheet" type="text/css" href="/JspProject/project/_res/knu/_share/css/announcement-mini-board-template-08-representative.widget1270.css" />
<link rel="stylesheet" type="text/css" href="/JspProject/project/_res/knu/aisw/css/main3d9d.css" />
<link rel="stylesheet" type="text/css" href="/JspProject/project/_res/knu/aisw/css/main-content01.content7204.css" />
<script defer type="text/javascript" src="/JspProject/project/_res/_common/js/cms.js"></script>
<script defer type="text/javascript" src="/JspProject/project/_res/knu/aisw/js/main-content01.content7204.js" ></script>
<%@ include file="dbconn.jsp" %>	

<div class="main-content-wrap01 cms-edit" id="cms-content">
<% 
	Vector f_id = new Vector();
	Vector f_sub = new Vector();
	Vector f_date = new Vector();
	Vector f_text = new Vector();
	Vector g_id = new Vector();
	Vector g_sub = new Vector();
	Vector g_date = new Vector();
	Vector g_text = new Vector();
	Vector d_id = new Vector();
	Vector d_sub = new Vector();
	Vector d_date = new Vector();
	Vector d_text = new Vector();
	Statement st =null;
%>
	
<div class="main-content-box main-content-box01">
<div class="main-mini-wrap">
<div class="main-mini-box main-mini-box01">
<div class="mini-tab-box">
<ul>
<li class="active"><a class="mini-board-tab " href="#a" title="공지사항">공지사항</a>
<div class="mini-board-content">	
<div class="main-notice-box temp08">
<ul>
			
<%	  	
		  	ResultSet rs =null;
	  		st = con.createStatement();
	  		String sql = "select * from freeboard order by";
	  	  	sql = sql + " masterid desc, replynum, step, id";
	  	  	rs = st.executeQuery(sql);
	  	  	
	  	  	if (!(rs.next()))  {
	  		   out.println("<li>게시판에 올린 글이 없습니다</li>");
	  		}
	  	  	
	  	  	else {
	  	  		do{
	  	  			f_id.addElement(new Integer(rs.getInt("id")));
	  	  			f_sub.addElement(rs.getString("subject"));
	  	  			f_date.addElement(rs.getString("inputdate"));
	  	  			f_text.addElement(rs.getString("content"));
	  	  		}
	  	  		while(rs.next());
	  	  		int roop = 0;
	  	  		if(f_id.size() > 3) roop = 3;
	  	  		else roop = f_id.size();
	  	  		for (int i = 0; i < roop; i++){
	  	  			String date1 = f_date.elementAt(i).toString();
	  	  			
	  	  			String year = date1.substring(0, 2);
	  	  			String month = date1.substring(3, 5);
	  	  			String day = date1.substring(6, 8);
	  	  			out.println("<li>");
	  	  			out.println("<p class='mini-date'><span>"+ day +"</span>"+year+"."+month+"</p>");
  	  				out.println("<div class='mini-txt-box'>");
  	  				out.println("<p class='mini-title'>");
  	  				out.println("<a href='community/freeboard/freeboard_read.jsp?table=freeboard&id="+ f_id.elementAt(i) + "&page=1' title='자세히보기'>");
  	  				out.println(f_sub.elementAt(i) + "</a></p>");
  	  				out.println("<p class='mini-txt'>");
  	  				out.println("<a href='community/freeboard/freeboard_read.jsp?table=freeboard&id="+ f_id.elementAt(i) + "&page=1' title=자세히보기>");
  					//out.println(content + "</a></p>");
  					out.println(f_text.elementAt(i) + "</a></p></div>");
  					out.println("</li>");
	  	  		}
	  	  	 rs.close();
	  	  	}
	  	  //st.close();

	  	
%>
</ul>
</div>
</div>
<a class="btn-more" href="community/freeboard/freeboard_list.jsp?table=freeboard" title="공지사항 바로가기 ">더보기</a>
</li>					
<li><a class="mini-board-tab" href="#a" title="갤러리">갤러리</a>
<div class="mini-board-content">					
<div class="main-notice-box temp08">
<ul>				
<%	  	
			//Statement st1 =null;
		  	ResultSet rs1 =null;
	  		st = con.createStatement();
	  		String sql1 = "select * from gallery order by";
	  	  	sql1 = sql1 + " masterid desc, replynum, step, id";
	  	  	rs1 = st.executeQuery(sql1);
	  	  	
	  	  	if (!(rs1.next()))  {
	  		   out.println("<li>게시판에 올린 글이 없습니다</li>");
	  		}
	  	  	
	  	  	else {
	  	  		do{
	  	  			g_id.addElement(new Integer(rs1.getInt("id")));
	  	  			g_sub.addElement(rs1.getString("subject"));
	  	  			g_date.addElement(rs1.getString("inputdate"));
	  	  			g_text.addElement(rs1.getString("content"));
	  	  		}
	  	  		while(rs1.next());
	  	  		int roop1 = 0;
	  	  		if(g_id.size() > 3) roop1 = 3;
  	  			else roop1 = g_id.size();
	  	  		for (int i = 0; i < 1; i++){
	  	  			String date1 = g_date.elementAt(i).toString();
	  	  			String day = date1.substring(6, 8);
	  	  			String year = date1.substring(0, 2);
	  	  			String month = date1.substring(3, 5);
	  	  			out.println("<li>");
	  	  			out.println("<p class='mini-date'><span>"+ day +"</span>"+year+"."+month+"</p>");
  	  				out.println("<div class='mini-txt-box'>");
  	  				out.println("<p class='mini-title'>");
  	  				out.println("<a href='community/freeboard/freeboard_read.jsp?table=freeboard&id="+ g_id.elementAt(i) + "&page=1' title='자세히보기'>");
  	  				out.println(g_sub.elementAt(i) + "</a></p>");
  	  				out.println("<p class='mini-txt'>");
  	  				out.println("<a href='community/freeboard/freeboard_read.jsp?table=freeboard&id="+ g_id.elementAt(i) + "&page=1' title=자세히보기>");
  					//out.println(content + "</a></p>");
  					out.println(g_text.elementAt(i) + "</a></p></div>");
  					out.println("</li>");
	  	  		}
	  	  		rs1.close();
	  	  	}
	  	  	//st1.close();
%>
</ul>
</div>
</div>
<a class="btn-more" href="community/freeboard/freeboard_list.jsp?table=gallery" target="_blank" title="갤러리 바로가기">더보기</a></li>
</ul>
</div>
</div>
<div class="main-mini-box main-mini-box02">
<h3 class="main-title">서식자료실</h3>
<div class="main-notice-box temp08">
<ul>
<%	  	
			//Statement st2 =null;
		  	ResultSet rs2 =null;
	  		st = con.createStatement();
	  		String sql2 = "select * from dataroom order by";
	  	  	sql2 = sql2 + " masterid desc, replynum, step, id";
	  	  	rs2 = st.executeQuery(sql2);
	  	  	
	  	  	if (!(rs2.next()))  {
	  		   out.println("<li>게시판에 올린 글이 없습니다</li>");
	  		}
	  	  	
	  	  	else {
	  	  		do{
	  	  			d_id.addElement(new Integer(rs2.getInt("id")));
	  	  			d_sub.addElement(rs2.getString("subject"));
	  	  			d_date.addElement(rs2.getString("inputdate"));
	  	  			d_text.addElement(rs2.getString("content"));
	  	  		}
	  	  		while(rs2.next());
	  	  		int roop2 = 0;
	  			if(d_id.size() > 3) roop2 = 3;
  				else roop2 = d_id.size();
	  	  		for (int i = 0; i < 1; i++){
	  	  			String date1 = d_date.elementAt(i).toString();
	  	  			String day = date1.substring(6, 8);
	  	  			String year = date1.substring(0, 2);
	  	  			String month = date1.substring(3, 5);
	  	  			out.println("<li>");
	  	  			out.println("<p class='mini-date'><span>"+ day +"</span>"+year+"."+month+"</p>");
  	  				out.println("<div class='mini-txt-box'>");
  	  				out.println("<p class='mini-title'>");
  	  				out.println("<a href='community/freeboard/freeboard_read.jsp?table=freeboard&id="+ d_id.elementAt(i) + "&page=1' title='자세히보기'>");
  	  				out.println(d_sub.elementAt(i) + "</a></p>");
  	  				out.println("<p class='mini-txt'>");
  	  				out.println("<a href='community/freeboard/freeboard_read.jsp?table=freeboard&id="+ d_id.elementAt(i) + "&page=1' title=자세히보기>");
  					//out.println(content + "</a></p>");
  					out.println(d_text.elementAt(i) + "</a></p></div>");
  					out.println("</li>");
	  	  		}
	  	  		rs2.close();
	  	  	}
	  	  	//st2.close();
%>		
</ul>
</div>
<a class="btn-more" href="community/freeboard/freeboard_list.jsp?table=dataroom" title="서식자료실 바로가기 ">더보기</a>
</div>
</div>
</div> 	
<%
  st.close();
  con.close();
%>
<br><br><br><br>
</div>