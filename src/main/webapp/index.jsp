<%--
  Created by IntelliJ IDEA.
  User: karinavladykina
  Date: 11.11.2021
  Time: 11:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.Result" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description"
          content="Web-programming lab work #2. ITMO University. Faculty of Software Engineering and Computer Systems.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="Vladykina Karina">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;700&display=swap" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <title>Web lab2</title>
</head>
<body>
<header>
    <span>Vladykina Karina, P3233</span>
    <span id="variant">#33129</span>
</header>
<%
    ArrayList<Result> results = new ArrayList<>();
    if (request.getServletContext().getAttribute("results") != null) {
        results = (ArrayList<Result>) request.getServletContext().getAttribute("results");
    }
%>
<div class="table">
    <table>
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
        <tbody>
        <%
            for (Result result : results) {
        %>
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
    </table>
</div>
<div class="plane">
    <svg xmlns="http://www.w3.org/2000/svg" width="300" height="300">
        <line x1="0" y1="150" x2="300" y2="150" stroke="#000720"></line>
        <line x1="150" y1="0" x2="150" y2="300" stroke="#000720"></line>
        <line x1="270" y1="148" x2="270" y2="152" stroke="#000720"></line>
        <text x="265" y="140">R</text>
        <line x1="210" y1="148" x2="210" y2="152" stroke="#000720"></line>
        <text x="200" y="140">R/2</text>
        <line x1="90" y1="148" x2="90" y2="152" stroke="#000720"></line>
        <text x="75" y="140">-R/2</text>
        <line x1="30" y1="148" x2="30" y2="152" stroke="#000720"></line>
        <text x="20" y="140">-R</text>
        <line x1="148" y1="30" x2="152" y2="30" stroke="#000720"></line>
        <text x="156" y="35">R</text>
        <line x1="148" y1="90" x2="152" y2="90" stroke="#000720"></line>
        <text x="156" y="95">R/2</text>
        <line x1="148" y1="210" x2="152" y2="210" stroke="#000720"></line>
        <text x="156" y="215">-R/2</text>
        <line x1="148" y1="270" x2="152" y2="270" stroke="#000720"></line>
        <text x="156" y="275">-R</text>
        <polygon points="300,150 295,155 295, 145" fill="#000720" stroke="#000720"></polygon>
        <polygon points="150,0 145,5 155,5" fill="#000720" stroke="#000720"></polygon>
        <rect x="150" y="150" width="120" height="60" fill-opacity="0.4" stroke="navy" fill="blue"></rect>
        <polygon points="150,150 90,150 150,90" fill-opacity="0.4" stroke="navy" fill="blue"></polygon>
        <path d="M 150 90 A 120 120 0 0 1 210 150 L 150 150 Z" fill-opacity="0.4" stroke="navy" fill="blue"></path>
        <circle id="pointer" r="5" cx="150" cy="150" fill-opacity="0.7" fill="red" stroke="firebrick" visibility="hidden"></circle>

        <%
            for (Result result : results) {
        %>
        <circle r="5" cx="<%=150 + Math.round(120 * result.getX() / result.getR())%>"
                cy="<%=150 - Math.round(120 * result.getY() / result.getR())%>" fill="cyan"
                fill-opacity="0.85"></circle>
        <%
            }
        %>
    </svg>
</div>
<div class="form">
    <form method="post">
        <br>
        <br>
        <div>
            <label>Y value:</label>
            <label><input type="text" size="38" maxlength="4" name="y-value"
                          placeholder="Y ∈ ( -3 ; 3 )"></label>
        </div>
        <br>
        <div>
            <label>R value:</label>
            <label class="checkbox"><input type="checkbox" name="r-value" value="1">1</label>
            <label class="checkbox"><input type="checkbox" name="r-value" value="2">2</label>
            <label class="checkbox"><input type="checkbox" name="r-value" value="3">3</label>
            <label class="checkbox"><input type="checkbox" name="r-value" value="4">4</label>
            <label class="checkbox"><input type="checkbox" name="r-value" value="5">5</label>
        </div>
        <br>
        <div id="r-buttons">
            <label>X value:</label>
            <button type="button" name="x-value" value="-2">-2</button>
            <button type="button" name="x-value" value="-1.5">-1.5</button>
            <button type="button" name="x-value" value="-1">-1</button>
            <button type="button" name="x-value" value="-0.5">-0.5</button>
            <button type="button" name="x-value" value="0">0</button>
            <button type="button" name="x-value" value="0.5">0.5</button>
            <button type="button" name="x-value" value="1">1</button>
            <button type="button" name="x-value" value="1.5">1.5</button>
            <button type="button" name="x-value" value="2">2</button>
        </div>
        <br>
        <div class="main-buttons">
            <button type="submit">Submit</button>
            <button type="reset">Reset</button>
        </div>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>