<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.ServletUtils" %>
<%
    String filePath = request.getParameter("filepath");
    String filename = request.getParameter("filename");
    
    ServletContext context = getServletContext();
    
    byte[] b = new byte[4096];
    File file = new File(filePath);
    FileInputStream input = new FileInputStream(filePath);
    String mimeType = getServletContext().getMimeType(filePath);
    if (mimeType == null) {
        mimeType = "application/octet-stream";
    }
    response.setContentType(mimeType);
    String encodedFilename = new String(filename.getBytes("utf-8"), "8859_1");
    response.setHeader("Content-Disposition", "attachment; filename=" + encodedFilename);
    ServletOutputStream output = response.getOutputStream();
    int numRead;
    while((numRead = input.read(b,0,b.length)) != -1 ) {
        output.write(b, 0, numRead);
    }    
    output.flush();
    output.close();
    input.close();
%>