<%@ page import="com.service.spring.domain.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Member member = (Member) session.getAttribute("member");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Spending Management</title>
    <!-- Chart.js 로드 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>

    <!-- plugins:css -->
    <link rel="stylesheet" href="<c:url value="/vendors/feather/feather.css"/>">
    <link rel="stylesheet" href="<c:url value="/vendors/ti-icons/css/themify-icons.css"/>">
    <link rel="stylesheet" href="<c:url value="/vendors/css/vendor.bundle.base.css"/>">
    <!-- endinject -->
    <!-- Plugin css for this page -->
    <link rel="stylesheet" href="<c:url value="/vendors/datatables.net-bs4/dataTables.bootstrap4.css"/>">
    <link rel="stylesheet" href="<c:url value="/vendors/ti-icons/css/themify-icons.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/js/select.dataTables.min.css"/>">
    <!-- End plugin css for this page -->
    <!-- inject:css -->
    <link rel="stylesheet" href="<c:url value="/css/vertical-layout-light/style.css"/>">
    <!-- endinject -->
    <%--<link rel="shortcut icon" href="<c:url value="/images/favicon.png"/>" />--%>
    <style>
        body {
            background-color: #f5f7fa;
            font-family:'Jua',sans-serif;
            margin: 0;
            padding: 20px;
        }

        /* Card 스타일 */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
            background: white;
            margin-bottom: 20px;
        }

        .card-body {
            padding: 24px;
        }

        /* 지출 정보 섹션 */
        .info-section {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        /* 지출 항목 기본 스타일 */
        .expense-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .expense-item:last-child {
            margin-bottom: 0;
        }

        /* 지출 목표 특별 스타일 */
        .target-expense {
            background: #f3f0ff;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .target-expense.editing {
            border-color: #8b5cf6;
            background: #ffffff;
        }

        /* 라벨 스타일 */
        .expense-label {
            font-size: 15px;
            font-weight: 500;
            color: #374151;
        }

        /* 금액 스타일 */
        .expense-amount {
            font-size: 16px;
            font-weight: 600;
            color: #111827;
        }

        /* 색상 클래스들 */
        .amount-purple {
            color: #8b5cf6;
        }

        .amount-gray {
            color: #6b7280;
        }

        .amount-red {
            color: #ef4444;
        }

        /* 입력 필드 스타일 */
        .expense-input {
            border: none;
            background: transparent;
            font-size: 16px;
            font-weight: bold;
            color: #8b5cf6;
            text-align: right;
            outline: none;
            width: 120px;
        }

        .expense-input:focus {
            background: #f9fafb;
            border-radius: 4px;
            padding: 2px 4px;
        }

        /* 버튼 컨테이너 */
        .expense-btn {
            text-align: right;
            height: 0;
            overflow: hidden;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        .expense-btn.visible {
            height: auto;
            margin-top: 10px;
            margin-bottom: 10px;
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        /* 이번 달 수입/지출 요약 스타일 */
        .summary-card {
            font-weight: bold;
        }

        .summary-amount {
            text-align: end;
        }

        /* 버튼 스타일 */
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .btn-primary {
            background-color: #8b5cf6;
            color: white;
        }

        .btn-primary:hover {
            background-color: #7c3aed;
        }

        .btn-secondary {
            background-color: #6b7280;
            color: white;
            margin-right: 8px;
        }

        .btn-secondary:hover {
            background-color: #4b5563;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .card-body {
                padding: 16px;
            }
        }

        /* Chart Card Styles */
        .chart-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            background: white;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            max-width: 800px;
            margin: 0 auto;
        }

        /*.chart-card:hover {*/
        /*    transform: translateY(-5px);*/
        /*    box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);*/
        /*}*/

        .chart-card .card-body {
            padding: 30px;
        }

        /* Chart Header Styles */
        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .chart-header .card-title {
            font-size: 20px;
            font-weight: 700;
            color: #000000;
            margin: 0;
            /* background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); */
            background: #000000;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        /* Year Selector Styles */
        .year-selector {
            display: flex;
            align-items: center;
            gap: 15px;
            background: #f8f9fa;
            padding: 8px 15px;
            border-radius: 30px;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.06);
        }

        .year-selector button {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: none;
            background: white;
            color: #667eea;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.15);
        }

        .year-selector button:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .year-selector button:active {
            transform: scale(0.95);
        }

        #yearDisplay {
            font-size: 18px;
            font-weight: 600;
            color: #2d3436;
            min-width: 60px;
            text-align: center;
            user-select: none;
        }

        /* Chart Container Styles */
        .chart-container {
            position: relative;
            height: 400px;
            padding: 20px 0;
            /*background: linear-gradient(180deg, rgba(102, 126, 234, 0.03) 0%, rgba(255, 255, 255, 0) 100%); */
            border-radius: 15px;
        }

        .chart-container canvas {
            max-height: 100%;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .chart-card .card-body {
                padding: 20px;
            }

            .chart-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .chart-header .card-title {
                font-size: 20px;
            }

            .chart-container {
                height: 300px;
            }
        }

        /*!* Loading Animation (optional) *!*/
        /*@keyframes pulse {*/
        /*    0% {*/
        /*        opacity: 1;*/
        /*    }*/
        /*    50% {*/
        /*        opacity: 0.5;*/
        /*    }*/
        /*    100% {*/
        /*        opacity: 1;*/
        /*    }*/
        /*}*/

        .chart-loading {
            animation: pulse 1.5s ease-in-out infinite;
        }
    </style>
</head>
<body>
<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <!-- 헤더 컴포넌트 -->
    <jsp:include page="/components/header.jsp"/>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_settings-panel.html -->
        <div class="theme-setting-wrapper">
            <div id="settings-trigger"><i class="ti-settings"></i></div>
            <div id="theme-settings" class="settings-panel">
                <i class="settings-close ti-close"></i>
                <p class="settings-heading">SIDEBAR SKINS</p>
                <div class="sidebar-bg-options selected" id="sidebar-light-theme">
                    <div class="img-ss rounded-circle bg-light border mr-3"></div>
                    Light
                </div>
                <div class="sidebar-bg-options" id="sidebar-dark-theme">
                    <div class="img-ss rounded-circle bg-dark border mr-3"></div>
                    Dark
                </div>
                <p class="settings-heading mt-2">HEADER SKINS</p>
                <div class="color-tiles mx-0 px-4">
                    <div class="tiles success"></div>
                    <div class="tiles warning"></div>
                    <div class="tiles danger"></div>
                    <div class="tiles info"></div>
                    <div class="tiles dark"></div>
                    <div class="tiles default"></div>
                </div>
            </div>
        </div>
        <div id="right-sidebar" class="settings-panel">
            <i class="settings-close ti-close"></i>
            <ul class="nav nav-tabs border-top" id="setting-panel" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="todo-tab" data-toggle="tab" href="#todo-section" role="tab"
                       aria-controls="todo-section" aria-expanded="true">TO DO LIST</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="chats-tab" data-toggle="tab" href="#chats-section" role="tab"
                       aria-controls="chats-section">CHATS</a>
                </li>
            </ul>
            <div class="tab-content" id="setting-content">
                <div class="tab-pane fade show active scroll-wrapper" id="todo-section" role="tabpanel"
                     aria-labelledby="todo-section">
                    <div class="add-items d-flex px-3 mb-0">
                        <form class="form w-100">
                            <div class="form-group d-flex">
                                <input type="text" class="form-control todo-list-input" placeholder="Add To-do">
                                <button type="submit" class="add btn btn-primary todo-list-add-btn" id="add-task">Add
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="list-wrapper px-3">
                        <ul class="d-flex flex-column-reverse todo-list">
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="checkbox" type="checkbox">
                                        Team review meeting at 3.00 PM
                                    </label>
                                </div>
                                <i class="remove ti-close"></i>
                            </li>
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="checkbox" type="checkbox">
                                        Prepare for presentation
                                    </label>
                                </div>
                                <i class="remove ti-close"></i>
                            </li>
                            <li>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="checkbox" type="checkbox">
                                        Resolve all the low priority tickets due today
                                    </label>
                                </div>
                                <i class="remove ti-close"></i>
                            </li>
                            <li class="completed">
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="checkbox" type="checkbox" checked>
                                        Schedule meeting for next week
                                    </label>
                                </div>
                                <i class="remove ti-close"></i>
                            </li>
                            <li class="completed">
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="checkbox" type="checkbox" checked>
                                        Project review
                                    </label>
                                </div>
                                <i class="remove ti-close"></i>
                            </li>
                        </ul>
                    </div>
                    <h4 class="px-3 text-muted mt-5 font-weight-light mb-0">Events</h4>
                    <div class="events pt-4 px-3">
                        <div class="wrapper d-flex mb-2">
                            <i class="ti-control-record text-primary mr-2"></i>
                            <span>Feb 11 2018</span>
                        </div>
                        <p class="mb-0 font-weight-thin text-gray">Creating component page build a js</p>
                        <p class="text-gray mb-0">The total number of sessions</p>
                    </div>
                    <div class="events pt-4 px-3">
                        <div class="wrapper d-flex mb-2">
                            <i class="ti-control-record text-primary mr-2"></i>
                            <span>Feb 7 2018</span>
                        </div>
                        <p class="mb-0 font-weight-thin text-gray">Meeting with Alisa</p>
                        <p class="text-gray mb-0 ">Call Sarah Graves</p>
                    </div>
                </div>
                <!-- To do section tab ends -->
                <div class="tab-pane fade" id="chats-section" role="tabpanel" aria-labelledby="chats-section">
                    <div class="d-flex align-items-center justify-content-between border-bottom">
                        <p class="settings-heading border-top-0 mb-3 pl-3 pt-0 border-bottom-0 pb-0">Friends</p>
                        <small class="settings-heading border-top-0 mb-3 pt-0 border-bottom-0 pb-0 pr-3 font-weight-normal">See
                            All</small>
                    </div>
                    <ul class="chat-list">
                        <li class="list active">
                            <div class="profile"><img src="images/faces/face1.jpg" alt="image"><span
                                    class="online"></span></div>
                            <div class="info">
                                <p>Thomas Douglas</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">19 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face2.jpg" alt="image"><span
                                    class="offline"></span></div>
                            <div class="info">
                                <div class="wrapper d-flex">
                                    <p>Catherine</p>
                                </div>
                                <p>Away</p>
                            </div>
                            <div class="badge badge-success badge-pill my-auto mx-2">4</div>
                            <small class="text-muted my-auto">23 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face3.jpg" alt="image"><span
                                    class="online"></span></div>
                            <div class="info">
                                <p>Daniel Russell</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">14 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face4.jpg" alt="image"><span
                                    class="offline"></span></div>
                            <div class="info">
                                <p>James Richardson</p>
                                <p>Away</p>
                            </div>
                            <small class="text-muted my-auto">2 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face5.jpg" alt="image"><span
                                    class="online"></span></div>
                            <div class="info">
                                <p>Madeline Kennedy</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">5 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face6.jpg" alt="image"><span
                                    class="online"></span></div>
                            <div class="info">
                                <p>Sarah Graves</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">47 min</small>
                        </li>
                    </ul>
                </div>
                <!-- chat tab ends -->
            </div>
        </div>
        <!-- partial -->
        <!-- partial:partials/_sidebar.html -->
        <!-- 네비게이션 바 -->
        <jsp:include page="/components/navbar.jsp"/>
        <!-- partial -->
        <div class="main-panel">
            <div class="content-wrapper">
                <div class="row">
                    <!-- Left Column - Expense Chart -->
                    <div class="col-md-7 mb-4">
                        <div class="card chart-card">
                            <div class="card-body">
                                <div class="chart-header">
                                    <p class="card-title">Expenses Overview</p>
                                    <div class="year-selector">
                                        <button onclick="changeYear(-1)">‹</button>
                                        <span id="yearDisplay">2025</span>
                                        <button onclick="changeYear(1)">›</button>
                                    </div>
                                </div>
                                <div class="chart-container">
                                    <canvas id="expenseChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column - Info Cards -->
                    <div class="col-md-5">
                        <div class="row">
                            <!-- Left Info Card -->
                            <div class="col-md-7 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="info-section">
                                            <!-- 지출 목표 설정 (편집 가능) -->
                                            <div class="expense-item target-expense" id="targetExpense">
                                                <span class="expense-label">지출 목표</span>
                                                <input type="text" class="expense-input" id="expenseInput" value="₩ 300,000" readonly>
                                            </div>

                                            <!-- 편집 버튼들 -->
                                            <div class="expense-btn" id="expenseBtn">
                                                <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
                                                <button type="button" class="btn btn-primary" onclick="saveEdit()">저장</button>
                                            </div>

                                            <!-- 기타 지출 정보들 (읽기 전용) -->
                                            <div class="expense-item">
                                                <span class="expense-label">하루 목표</span>
                                                <span id="dailyTarget" class="expense-amount amount-gray">₩ 10,000</span>
                                            </div>

                                            <div class="expense-item">
                                                <span class="expense-label">오늘 지출</span>
                                                <span class="expense-amount amount-red">₩ 12,000</span>
                                            </div>

                                            <div class="expense-item">
                                                <span class="expense-label">현재 지출</span>
                                                <span class="expense-amount amount-red">₩ 460,000</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Summary Cards -->
                            <div class="col-md-5">
                                <!-- Monthly Income Card -->
                                <div class="card mb-3">
                                    <div class="card-body summary-card">
                                        <div class="summary-label">이번 달 수입</div>
                                        <div class="summary-amount amount-green">₩ 300,000</div>
                                    </div>
                                </div>

                                <!-- Monthly Expense Card -->
                                <div class="card">
                                    <div class="card-body summary-card">
                                        <div class="summary-label">이번 달 지출</div>
                                        <div class="summary-amount amount-red">₩ 460,000</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 grid-margin stretch-card">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <%-- 가계부 목록 테이블 --%>
                                    <div class="col-12">
                                        <div class="table-responsive" style="height: 400px; overflow-y: auto;">
                                            <table id="accountTable" class="table dataTable display expandable-table"
                                                   style="width:100%">
                                                <thead style="position: sticky; top: 0; background-color: #fff; z-index: 10;">
                                                <tr>
                                                    <th>날짜</th>
                                                    <th>구분</th>
                                                    <th>분류</th>
                                                    <th>내용</th>
                                                    <th>금액</th>
                                                    <th>결제수단</th>
                                                    <th>비고</th>
                                                    <th>
                                                    </th>
                                                    <th>
                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody id="accountTableBody">

                                                </tbody>
                                                <tfoot style="position: sticky; bottom: 0; background-color: #fff; z-index: 10;">
                                                <tr id="addAccListForm">
                                                    <td>
                                                        <input type="date" name="acc_date" class="form-control"
                                                               aria-describedby="inputGroup-sizing-sm"
                                                               value="${currentDate}"/>
                                                    </td>
                                                    <td>
                                                        <select name="acc_income" class="form-control"
                                                                aria-describedby="inputGroup-sizing-sm"
                                                                style="width: fit-content;">
                                                            <option value='0'>지출</option>
                                                            <option value='1'>수입</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="acc_category" class="form-control"
                                                               aria-describedby="inputGroup-sizing-sm"/>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="acc_desc" class="form-control"
                                                               aria-describedby="inputGroup-sizing-sm"/>
                                                    </td>
                                                    <td>
                                                        <input type="number" name="acc_amount" class="form-control"
                                                               aria-describedby="inputGroup-sizing-sm"/>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="acc_payment" class="form-control"
                                                               aria-describedby="inputGroup-sizing-sm"/>
                                                    </td>
                                                    <td>
                                                        <input type="text" name="acc_etc" class="form-control"
                                                               aria-describedby="inputGroup-sizing-sm"/>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-sm btn-success mr-1"
                                                                id="addAccListBtn" title="추가">
                                                            <i class="fas fa-plus">+</i>
                                                        </button>
                                                    </td>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- content-wrapper ends -->
            <!-- partial:partials/_footer.html -->
            <footer class="footer">
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2021.  Premium <a
                            href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a> from BootstrapDash. All rights reserved.</span>
                    <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i
                            class="ti-heart text-danger ml-1"></i></span>
                </div>
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Distributed by <a
                            href="https://www.themewagon.com/" target="_blank">Themewagon</a></span>
                </div>
            </footer>
            <!-- partial -->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->

<!-- plugins:js -->
<script src="/vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="/vendors/chart.js/Chart.min.js"></script>
<script src="/vendors/datatables.net/jquery.dataTables.js"></script>
<script src="/vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
<script src="/js/dataTables.select.min.js"></script>

<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="<c:url value="/js/off-canvas.js"/>"></script>
<script src="<c:url value="/js/hoverable-collapse.js"/>"></script>
<script src="<c:url value="/js/template.js"/>"></script>
<script src="<c:url value="/js/settings.js"/>"></script>
<script src="<c:url value="/js/todolist.js"/>"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="<c:url value="/js/dashboard.js"/>"></script>
<script src="<c:url value="/js/Chart.roundedBarCharts.js"/>"></script>
<!-- End custom js for this page-->

<script src="<c:url value="/js/account/account-charts.js"/>"></script>

<script>
    // 가계부 테이블
    let table;
    // 해당 달의 가계부 리스트
    let accMonthList


    (async () => {
        await getMonthAccList('2025-08-01');
        sumMonthIncome();
        //sumMonthOutcome();
    })();

    /* 이벤트 목록 */
    // 페이지 로드 시 실행
    $(document).ready(function () {
        getAccList();
        getEdit();
    });

    // 추가 버튼 이벤트 (동적 요소이므로 위임)
    $(document).on("click", "#addAccListBtn", function () {
        const accId = $('#addAccListBtn').data('id');
        console.log(accId);
        saveAccount();
        table.ajax.reload(null, false);
        clearForm();
    });

    // 삭제 버튼 이벤트 (동적 요소이므로 위임)
    $(document).on("click", "#delete-btn", function () {
        if (confirm("정말 삭제하시겠습니까?")) {
            const accId = $('#delete-btn').data('id');
            console.log(accId);
            deleteAccount(accId);
            table.ajax.reload(null, false);
        }
    });

    /* 함수 목록 */

    // 가계부 목록 가져오기
    function getAccList() {
        // 4. DataTable 초기화 (심플 버전)
        const date = new Date();
        const curDate = date.toISOString().substring(0, 10);

        try {
            table = $('#accountTable').DataTable({
                "ajax": {
                    "url": "/getMonthAcc?date=" + curDate,
                    "type": "GET",
                    "dataType": "json",
                    "error": function (xhr, error, thrown) {
                        console.error("DataTable Ajax 에러:");
                        console.error("Error:", error);
                        console.error("Thrown:", thrown);
                        console.error("Status:", xhr.status);
                        console.error("Response:", xhr.responseText);
                    },
                    "dataSrc": function (response) {
                        console.log("DataTable dataSrc 응답:", response);

                        // 다양한 응답 형식 처리
                        if (Array.isArray(response)) {
                            console.log("응답이 배열입니다. 길이:", response.length);
                            return response;
                        } else if (response && response.data) {
                            console.log("응답에 data 속성이 있습니다. 길이:", response.data.length);
                            return response.data;
                        } else if (response && response.result) {
                            console.log("응답에 result 속성이 있습니다. 길이:", response.result.length);
                            return response.result;
                        } else {
                            console.warn("예상치 못한 응답 형식:", response);
                            return [];
                        }
                    }
                },
                "columns": [
                    {
                        "data": "accDate",
                        "defaultContent": "-"
                    },
                    {
                        "data": "accIncome",
                        "defaultContent": false,
                        "render": function (data) {
                            return data ? "수입" : "지출";
                        }
                    },
                    {
                        "data": "accCategory",
                        "defaultContent": "-"
                    },
                    {
                        "data": "accDesc",
                        "defaultContent": "-"
                    },
                    {
                        "data": "accAmount",
                        "defaultContent": "0",
                        "render": function (data) {
                            return Number(data || 0).toLocaleString() + "원";
                        }
                    },
                    {
                        "data": "accPayment",
                        "defaultContent": "-"
                    },
                    {
                        "data": "accEtc",
                        "defaultContent": "-"
                    },
                    {
                        "data": "accId",
                        "defaultContent": "",
                        "orderable": false,
                        "render": function (data) {
                            if (data) {
                                return '<button id="delete-btn" class="btn btn-sm btn-danger delete-btn" data-id="' + data + '">삭제</button>';
                            }
                            return '';
                        }
                    }
                ],
                "language": {
                    "emptyTable": "데이터가 없습니다.",
                    "loadingRecords": "로딩중...",
                    "processing": "처리중..."
                },
                "initComplete": function (settings, json) {
                    console.log("=== DataTable 초기화 완료 ===");
                    console.log("초기화 데이터:", json);
                    console.log("행 개수:", this.api().rows().count());
                },
            });
        } catch (e) {
            console.log(e);
        }
    }

    // 가계부 생성
    // 2. 가계부 추가
    function saveAccount() {
        // 폼 데이터 수집
        const formData = {
            accDate: $('input[name="acc_date"]').val(),
            accIncome: $("select[name=acc_income] option:selected").val() === "1",
            accCategory: $('input[name="acc_category"]').val(),
            accDesc: $('input[name="acc_desc"]').val(),
            accAmount: $('input[name="acc_amount"]').val() || 0,
            accPayment: $('input[name="acc_payment"]').val(),
            accEtc: $('input[name="acc_etc"]').val(),
        };

        // 유효성 검사
        if (!formData.accDate) {
            alert("날짜를 입력해주세요.");
            return;
        }

        if (!formData.accAmount || isNaN(formData.accAmount)) {
            alert("금액을 올바르게 입력해주세요.");
            return;
        }

        // Ajax 요청
        $.ajax({
            url: "/addAcc",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function (result) {
                // 폼 초기화
                clearForm();

                table.ajax.reload(null, false);
            },
        });
    }

    // 가계부 삭제
    function deleteAccount(accId) {
        $.ajax({
            url: "/deleteAcc",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(accId),
            success: function (result) {
                if (result !== -1) {
                    // DataTable 새로고침
                    table.ajax.reload(null, false);
                    alert("삭제되었습니다.");
                }
            },
            error: function (xhr, status, error) {
                alert("삭제 중 오류가 발생했습니다.");
            },
        });
    }


    // 현재 가계부 리스트만 가져오기
    async function getMonthAccList(date) {
        const queryParams = new URLSearchParams({
            date: date.toString()
        });

        fetch('/getMonthAcc?' + queryParams, {
            method: 'GET'
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 오류');
                }

                accMonthList = response;

            })
            .catch(error => {
                console.error('에러 발생:', error);
            });
    }

    // 해당 달의 총 수입
    function sumMonthIncome() {
        if (accMonthList === null)
            return 0;

        let sumMonthIncome = 0;

        console.log(accMonthList);

        return sumMonthIncome;
    }

    // 해당 달의 총 지출
    function sumMonthOutcome() {
        if (accMonthList === null)
            return 0;

        let sumMonthOutcome = 0;

        accMonthList.forEach((acc) => {

        })

        return sumMonthOutcome;
    }

    function clearForm() {
        $('#addAccListForm input[type="text"]').val("");
        // 날짜는 현재 날짜로 유지
        const today = new Date().toISOString().split("T")[0];
        $('input[name="acc_date"]').val(today);
        // 금액을 0원으로
        $('input[name="acc_amount"]').val(0);
    }

    // 가계부 리스트 로드
    function loadAccountList() {
        console.log("Load Account List!");

        $.ajax({
            url: "/getMonthAcc",
            type: "GET",
            success: function (data) {
                if (data && data.length > 0) {
                    renderAccountTable(data);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error loading account list:", error);
            },
        });
    }

    const targetExpense = document.getElementById('targetExpense');
    const expenseInput = document.getElementById('expenseInput');
    const expenseBtn = document.getElementById('expenseBtn');
    const dailyTarget = document.getElementById('dailyTarget');

    let isEditing = false;
    let originalValue = '';

    // 숫자를 천 단위 콤마 형식으로 변환
    function formatNumber(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

    // 콤마 제거하여 숫자만 추출
    function removeCommas(str) {
        return str.replace(/,/g, '');
    }

    // 표시용 형식으로 변환 (₩ + 콤마)
    function formatDisplay(value) {
        const numbers = removeCommas(value.replace('₩', '').trim());
        if (numbers === '' || isNaN(numbers)) return '₩ 0';
        return '₩ ' + formatNumber(numbers);
    }

    // 입력 필드 클릭 시 편집 모드 활성화
    expenseInput.addEventListener('click', function () {
        if (!isEditing) {
            startEdit();
        }
    });

    // 숫자만 입력 허용 및 실시간 포맷팅
    expenseInput.addEventListener('input', function (e) {
        if (!isEditing) return;

        let value = e.target.value;
        // 숫자가 아닌 문자 제거 (₩ 기호와 콤마 제외)
        let numbers = removeCommas(value.replace('₩', '').trim());

        // 숫자가 아닌 문자가 있으면 제거
        numbers = numbers.replace(/[^\d]/g, '');

        // 빈 값이면 0으로 설정
        if (numbers === '') {
            e.target.value = '';
        } else {
            // 앞의 0 제거 (단, 0만 있는 경우는 제외)
            numbers = numbers.replace(/^0+/, '') || '0';
            e.target.value = formatNumber(numbers);
        }
    });

    // 키 입력 제한 (숫자, 백스페이스, 방향키 등만 허용)
    expenseInput.addEventListener('keydown', function (e) {
        if (isEditing) {
            // 허용되는 키들
            const allowedKeys = [
                'Backspace', 'Delete', 'Tab', 'Escape', 'Enter',
                'ArrowLeft', 'ArrowRight', 'ArrowUp', 'ArrowDown',
                'Home', 'End'
            ];

            // 숫자 키 (0-9)
            const isNumber = (e.key >= '0' && e.key <= '9');

            // Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+X 허용
            const isCtrlKey = e.ctrlKey && ['a', 'c', 'v', 'x'].includes(e.key.toLowerCase());

            if (!isNumber && !allowedKeys.includes(e.key) && !isCtrlKey) {
                e.preventDefault();
            }

            // Enter 키로 저장, Escape 키로 취소
            if (e.key === 'Enter') {
                saveEdit();
            } else if (e.key === 'Escape') {
                cancelEdit();
            }
        }
    });

    // 입력 필드에서 포커스가 벗어날 때 (다른 곳 클릭)
    document.addEventListener('click', function (e) {
        if (isEditing && !targetExpense.contains(e.target) && !expenseBtn.contains(e.target)) {
            cancelEdit();
        }
    });

    // 목표값 표시
    function getEdit() {
        // 현재 날짜 가져오기
        const date = new Date();
        const year = date.getFullYear();
        const month = date.getMonth() + 1;

        // 수정한 값을 DB에 저장
        fetch("/get-target?year=" + year + "&month=" + month)
            .then((res) => res.json())
            .then((data) => {
                expenseInput.value = '₩ ' + formatNumber(data);
                dailyTarget.innerHTML = '₩ ' + formatNumber(Math.floor(data / getDaysInMonth(year, month)));
            })
    }

    function startEdit() {
        isEditing = true;
        originalValue = expenseInput.value;

        targetExpense.classList.add('editing');
        expenseBtn.classList.add('visible');
        expenseInput.readOnly = false;

        // ₩ 기호 제거하고 숫자만 표시
        const numbers = removeCommas(expenseInput.value.replace('₩', '').trim());
        expenseInput.value = formatNumber(numbers);

        expenseInput.focus();
        expenseInput.select(); // 전체 텍스트 선택
    }

    function cancelEdit() {
        isEditing = false;
        expenseInput.value = originalValue;

        targetExpense.classList.remove('editing');
        expenseBtn.classList.remove('visible');
        expenseInput.readOnly = true;
    }

    function saveEdit() {
        isEditing = false;

        // 입력값을 표시 형식으로 변환
        const currentValue = expenseInput.value.trim();
        if (currentValue === '' || currentValue === '0') {
            expenseInput.value = '₩ 0';
        } else {
            expenseInput.value = formatDisplay(currentValue);
        }

        targetExpense.classList.remove('editing');
        expenseBtn.classList.remove('visible');
        expenseInput.readOnly = true;

        // 저장 로직
        console.log('저장된 값:', expenseInput.value);

        // 현재 날짜 가져오기
        const date = new Date();
        const year = date.getFullYear();
        const month = date.getMonth() + 1;

        // 수정한 값을 DB에 저장
        fetch("/change-target", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                year: Number(year),
                month: Number(month),
                targetAcc: Number(parseInt(currentValue.replace(/[^0-9]/g, ''), 10)), // 숫자 보장
            }),
        });

    }

    // 페이스트 이벤트 처리
    expenseInput.addEventListener('paste', function (e) {
        if (!isEditing) return;

        e.preventDefault();
        const paste = (e.clipboardData || window.clipboardData).getData('text');
        const numbers = paste.replace(/[^\d]/g, '');

        if (numbers !== '') {
            this.value = formatNumber(numbers);
        }
    });

    function getDaysInMonth(year, month) {
        // month는 0부터 시작 (0=1월, 1=2월, ..., 11=12월)
        return new Date(year, month, 0).getDate();
    }
</script>
</body>

</html>

