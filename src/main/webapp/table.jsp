<%--
  Created by IntelliJ IDEA.
  User: karinavladykina
  Date: 11.11.2021
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Result" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    ArrayList<Result> results = new ArrayList<>();
    if (request.getServletContext().getAttribute("results") != null) {
        results = (ArrayList<Result>) request.getServletContext().getAttribute("results");
    }
%>
<thead>
<tr>
    <th class="coords-column">X</th>
    <th class="coords-column">Y</th>
    <th class="coords-column">R</th>
    <th class="time-column">Current time</th>
    <th class="time-column">Execution time</th>
    <th>Hit fact</th>
</tr>
</thead>
<%
    for (Result result : results) {
%>
<tbody>
<tr>
    <td><%=result.getX()%>
    </td>
    <td><%=result.getY()%>
    </td>
    <td><%=result.getR()%>
    </td>
    <td><%=result.getCurrentTime()%>
    </td>
    <td><%=result.getExecutionTime()%>
    </td>
    <td><%=result.getHitFact()%>
    </td>
</tr>
<%
    }
%>
</tbody>