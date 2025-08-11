<%@ page import="com.service.spring.domain.Member" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Member member = (Member)session.getAttribute("member");
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
    <link rel="shortcut icon" href="<c:url value="/images/favicon.png"/>" />
    <style>
        .main-panel {
            background-color: #F5F8F8;
        }

        .main-container {
            margin: 20px;

            display: flex;
            justify-content: space-between;
        }

        .profile-card {
            flex: 1.5;
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-right: 20px;
            border: 1px solid #e3e3e3;
        }

        .profile-card .row {
            flex-direction: column;
            align-items: center;
        }

        .character-circle {
            width: 200px;
            height: 200px;
            border: 3px solid #e0e0e0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #fff;
            margin: 0 auto 20px;
            position: relative;
        }

        /* CSS에서 수정/추가할 부분 */
        .sprout-character {
            width: 120px;  /* 이미지 크기 조절 */
            height: 120px;
            object-fit: contain;  /* 비율 유지하며 크기 조절 */
            animation: float 3s ease-in-out infinite;
        }

        /* 반응형 디자인을 위한 미디어 쿼리 */
        @media (max-width: 768px) {
            .sprout-character {
                width: 80px;
                height: 80px;
            }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .level-badge {
            font-size: 2.5rem;
            font-weight: bold;
            color: #6c757d;
            margin-bottom: 10px;
        }

        .character-name {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }

        .exp-container {
            margin-top: 20px;
        }

        .exp-label {
            font-weight: bold;
            color: #6c757d;
            margin-bottom: 10px;
            font-size: 1.2rem;
        }

        .progress {
            height: 30px;
            border-radius: 15px;
            background-color: #e9ecef;
            overflow: hidden;
        }

        .progress-bar {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            transition: width 0.5s ease;
        }

        .exp-text {
            font-size: 1.1rem;
            color: #6c757d;
            text-align: right;
            margin-top: 5px;
        }

        .ranking-card {
            flex: 1;
            background: white;
            border-radius: 20px;
            padding: 20px;
            border: 1px solid #e3e3e3;
        }

        .ranking-header {
            font-size: 1.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .ranking-table {
            width: 100%;
        }

        .ranking-table th {
            color: #6c757d;
            font-weight: 600;
            padding: 12px;
            border-bottom: 2px solid #e9ecef;
            text-align: center;
        }

        .ranking-table td {
            padding: 12px;
            border-bottom: 1px solid #f1f3f5;
            text-align: center;
            color: #495057;
        }

        .ranking-table tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }

        .rank-number {
            font-weight: bold;
            color: #667eea;
        }

        .level-badge-small {
            display: inline-block;
            padding: 4px 12px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: bold;
        }

        .expand-btn {
            background: none;
            border: none;
            color: #667eea;
            font-size: 1.2rem;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .expand-btn:hover {
            transform: scale(1.1);
        }

        .username {
            font-weight: 600;
            color: #333;
        }

        @media (max-width: 768px) {
            .character-circle {
                width: 150px;
                height: 150px;
            }

            .sprout-character {
                font-size: 70px;
            }

            .level-badge {
                font-size: 2rem;
            }

            .character-name {
                font-size: 1.5rem;
            }
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
                <div class="sidebar-bg-options selected" id="sidebar-light-theme"><div class="img-ss rounded-circle bg-light border mr-3"></div>Light</div>
                <div class="sidebar-bg-options" id="sidebar-dark-theme"><div class="img-ss rounded-circle bg-dark border mr-3"></div>Dark</div>
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
                    <a class="nav-link active" id="todo-tab" data-toggle="tab" href="#todo-section" role="tab" aria-controls="todo-section" aria-expanded="true">TO DO LIST</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="chats-tab" data-toggle="tab" href="#chats-section" role="tab" aria-controls="chats-section">CHATS</a>
                </li>
            </ul>
            <div class="tab-content" id="setting-content">
                <div class="tab-pane fade show active scroll-wrapper" id="todo-section" role="tabpanel" aria-labelledby="todo-section">
                    <div class="add-items d-flex px-3 mb-0">
                        <form class="form w-100">
                            <div class="form-group d-flex">
                                <input type="text" class="form-control todo-list-input" placeholder="Add To-do">
                                <button type="submit" class="add btn btn-primary todo-list-add-btn" id="add-task">Add</button>
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
                        <small class="settings-heading border-top-0 mb-3 pt-0 border-bottom-0 pb-0 pr-3 font-weight-normal">See All</small>
                    </div>
                    <ul class="chat-list">
                        <li class="list active">
                            <div class="profile"><img src="images/faces/face1.jpg" alt="image"><span class="online"></span></div>
                            <div class="info">
                                <p>Thomas Douglas</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">19 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face2.jpg" alt="image"><span class="offline"></span></div>
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
                            <div class="profile"><img src="images/faces/face3.jpg" alt="image"><span class="online"></span></div>
                            <div class="info">
                                <p>Daniel Russell</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">14 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face4.jpg" alt="image"><span class="offline"></span></div>
                            <div class="info">
                                <p>James Richardson</p>
                                <p>Away</p>
                            </div>
                            <small class="text-muted my-auto">2 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face5.jpg" alt="image"><span class="online"></span></div>
                            <div class="info">
                                <p>Madeline Kennedy</p>
                                <p>Available</p>
                            </div>
                            <small class="text-muted my-auto">5 min</small>
                        </li>
                        <li class="list">
                            <div class="profile"><img src="images/faces/face6.jpg" alt="image"><span class="online"></span></div>
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
            <div class="main-container">
                <!-- 프로필 카드 -->
                <div class="profile-card">
                    <div class="row">
                        <div class="col-md-4 text-center">
                            <div class="character-circle">
                                <%--<div class="sprout-character">🌱</div>--%>
                                <div>
                                    <img class="sprout-character" src="../../image/goal/tree01.png" alt="tree-img"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="level-badge">LV 5</div>
                            <div class="character-name">아직은 새싹</div>

                            <div class="exp-container">
                                <div class="exp-label">EXP</div>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" style="width: 20%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <div class="exp-text">2 / 10</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 랭킹 카드 -->
                <div class="ranking-card">
                    <div class="ranking-header">
                        <span>나무 랭킹</span>
                        <button class="expand-btn">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                    <table class="ranking-table">
                        <thead>
                        <tr>
                            <th style="width: 15%;">순위</th>
                            <th style="width: 45%;">사용자</th>
                            <th style="width: 40%;">레벨</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><span class="rank-number">5위</span></td>
                            <td><span class="username">나</span></td>
                            <td><span class="level-badge-small">LV 5</span></td>
                        </tr>
                        <tr>
                            <td><span class="rank-number">1위</span></td>
                            <td><span class="username">김철님#1322</span></td>
                            <td><span class="level-badge-small">LV 35</span></td>
                        </tr>
                        <tr>
                            <td><span class="rank-number">2위</span></td>
                            <td><span class="username">박작가씨#41</span></td>
                            <td><span class="level-badge-small">LV 22</span></td>
                        </tr>
                        <tr>
                            <td><span class="rank-number">3위</span></td>
                            <td><span class="username">장보고#11059</span></td>
                            <td><span class="level-badge-small">LV 19</span></td>
                        </tr>
                        <tr>
                            <td><span class="rank-number">4위</span></td>
                            <td><span class="username">고주몽#3</span></td>
                            <td><span class="level-badge-small">LV 8</span></td>
                        </tr>
                        <tr>
                            <td><span class="rank-number">5위</span></td>
                            <td><span class="username">나</span></td>
                            <td><span class="level-badge-small">LV 5</span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- content-wrapper ends -->
            <!-- partial:partials/_footer.html -->
            <footer class="footer">
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2021.  Premium <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a> from BootstrapDash. All rights reserved.</span>
                    <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i></span>
                </div>
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Distributed by <a href="https://www.themewagon.com/" target="_blank">Themewagon</a></span>
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

</script>
</body>

</html>

