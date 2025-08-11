<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Import Mdi Icon --%>
<link rel="stylesheet" href="../../vendors/mdi/css/materialdesignicons.min.css">

<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <li class="nav-item ${param.currentMenu == 'dashboard' ? 'active' : ''}">
            <a class="nav-link" href="<c:url value="/main"/>">
                <i class="icon-grid menu-icon"></i>
                <span class="menu-title">Dashboard</span>
            </a>
        </li>
        <li class="nav-item ${param.currentMenu == 'todo' ? 'active' : ''}">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                <i class="icon-layout menu-icon"></i>
                <span class="menu-title">To Do</span>
            </a>
        </li>
        <li class="nav-item ${param.currentMenu == 'account' ? 'active' : ''}">
            <a class="nav-link" href="<c:url value="/account"/>">
                <i class="icon-columns menu-icon"></i>
                <span class="menu-title">Spending Management</span>
            </a>
        </li>
        <li class="nav-item ${param.currentMenu == 'health' ? 'active' : ''}">
            <a class="nav-link" data-toggle="collapse" href="#charts" aria-expanded="false" aria-controls="charts">
                <i class="icon-bar-graph menu-icon"></i>
                <span class="menu-title">Health Care</span>
            </a>
        </li>
        <li class="nav-item ${param.currentMenu == 'notes' ? 'active' : ''}">
            <a class="nav-link" data-toggle="collapse" href="#tables" aria-expanded="false" aria-controls="tables">
                <i class="icon-grid-2 menu-icon"></i>
                <span class="menu-title">Notes</span>
            </a>
        </li>
        <li class="nav-item ${param.currentMenu == 'goal' ? 'active' : ''}">
            <a class="nav-link" href="<c:url value="/goal"/>">
                <i class="icon-target menu-icon"></i>
                <span class="menu-title">My Tree</span>
            </a>
        </li>
    </ul>
</nav>