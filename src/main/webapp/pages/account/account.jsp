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
    body {
      background-color: #f5f7fa;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    }

    .main-container {
      padding: 30px;
    }

    .card {
      border: none;
      border-radius: 12px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.08);
      margin-bottom: 20px;
    }

    .card-body {
      padding: 24px;
    }

    /* Chart Card */
    .chart-card {
      height: 100%;
      min-height: 380px;
    }

    .chart-container {
      position: relative;
      height: 280px;
      width: 100%;
    }

    /* Equal height cards */
    .h-100 {
      height: 100%;
    }

    .info-card-container {
      display: flex;
      flex-direction: column;
      height: 100%;
    }

    .info-card {
      min-height: 380px;
    }

    .summary-cards-container {
      display: flex;
      flex-direction: column;
      height: 100%;
    }

    .summary-card-wrapper {
      flex: 1;
      display: flex;
      flex-direction: column;
    }

    .summary-card-wrapper .card {
      flex: 1;
      display: flex;
      flex-direction: column;
    }

    .summary-card-wrapper .card-body {
      flex: 1;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .chart-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .card-title {
      font-size: 14px;
      font-weight: 500;
      color: #6b7280;
      margin: 0;
    }

    .year-selector {
      display: flex;
      align-items: center;
      gap: 12px;
      font-size: 14px;
      color: #374151;
    }

    .year-selector button {
      background: none;
      border: none;
      color: #9ca3af;
      font-size: 18px;
      cursor: pointer;
      padding: 0 5px;
    }

    .year-selector button:hover {
      color: #374151;
    }

    /* Expense Info Cards */
    .info-section {
      display: flex;
      flex-direction: column;
      height: 100%;
    }

    .expense-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 12px 0;
      border-bottom: 1px solid #f3f4f6;
    }

    .expense-item:last-child {
      border-bottom: none;
    }

    .expense-label {
      font-size: 15px;
      color: #374151;
      font-weight: 500;
    }

    .expense-amount {
      font-size: 20px;
      font-weight: 600;
      color: #111827;
    }

    .amount-purple {
      color: #8b5cf6;
    }

    .amount-gray {
      color: #6b7280;
    }

    .amount-red {
      color: #ef4444;
    }

    /* Summary Cards */
    .summary-card {
      text-align: center;
      padding: 20px;
    }

    .summary-label {
      font-size: 15px;
      color: #374151;
      font-weight: 500;
      margin-bottom: 8px;
    }

    .summary-amount {
      font-size: 24px;
      font-weight: 700;
    }

    .amount-green {
      color: #10b981;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
      .main-container {
        padding: 15px;
      }

      .card-body {
        padding: 16px;
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
                      <span id="yearDisplay">2021</span>
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
                <div class="col-md-6 mb-4">
                  <div class="card">
                    <div class="card-body">
                      <div class="info-section">
                        <div class="expense-item">
                          <span class="expense-label">지출 목표</span>
                          <span class="expense-amount amount-purple">₩ 300,000</span>
                        </div>
                        <div class="expense-item">
                          <span class="expense-label">하루 목표</span>
                          <span class="expense-amount amount-gray">₩ 10,000</span>
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
                <div class="col-md-6">
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
                        <table id="accountTable" class="table dataTable display expandable-table" style="width:100%">
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
                                <input type="date" name="acc_date" class="form-control" aria-describedby="inputGroup-sizing-sm" value="${currentDate}"/>
                              </td>
                              <td>
                                <select name="acc_income" class="form-control" aria-describedby="inputGroup-sizing-sm"
                                  style="width: fit-content;">
                                  <option value='0'>지출</option>
                                  <option value='1'>수입</option>
                                </select>
                              </td>
                              <td>
                                <input type="text" name="acc_category" class="form-control" aria-describedby="inputGroup-sizing-sm"/>
                              </td>
                              <td>
                                <input type="text" name="acc_desc" class="form-control" aria-describedby="inputGroup-sizing-sm"/>
                              </td>
                              <td>
                                <input type="number" name="acc_amount" class="form-control" aria-describedby="inputGroup-sizing-sm"/>
                              </td>
                              <td>
                                <input type="text" name="acc_payment" class="form-control" aria-describedby="inputGroup-sizing-sm"/>
                              </td>
                              <td>
                                <input type="text" name="acc_etc" class="form-control" aria-describedby="inputGroup-sizing-sm"/>
                              </td>
                              <td>
                                <button type="button" class="btn btn-sm btn-success mr-1" id="addAccListBtn" title="추가">
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
    $(document).ready(function() {
      // 4. DataTable 초기화 (심플 버전)
      try {
        var table = $('#accountTable').DataTable({
          "ajax": {
            "url": "/getMonthAcc",
            "type": "GET",
            "dataType": "json",
            "error": function(xhr, error, thrown) {
              console.error("DataTable Ajax 에러:");
              console.error("Error:", error);
              console.error("Thrown:", thrown);
              console.error("Status:", xhr.status);
              console.error("Response:", xhr.responseText);
            },
            "dataSrc": function(response) {
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
              "render": function(data) {
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
              "render": function(data) {
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
              "render": function(data) {
                if (data) {
                  return '<button class="btn btn-sm btn-danger delete-btn" data-id="' + data + '">삭제</button>';
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
          "initComplete": function(settings, json) {
            console.log("=== DataTable 초기화 완료 ===");
            console.log("초기화 데이터:", json);
            console.log("행 개수:", this.api().rows().count());
          }
        });

        console.log("DataTable 인스턴스 생성 성공");

      } catch(e) {
        console.error("DataTable 초기화 실패:", e);
      }
    });

    // 현재 가계부 리스트만 가져오기
    function getMonthAccList(date) {
      $.ajax({
        url: '/getMonthAcc',
        type: 'GET',
        success: function(result) {

        }
      });
    }

    // 해당 달의 총 수입
    function sumMonthIncome(accList) {
      if (accList === null)
        return 0;

      let sumMonthIncome = 0;

      console.log(accList);

      return sumMonthIncome;
    }

    // 해당 달의 총 지출
    function sumMonthOutcome(accList) {
      if (accList === null)
        return 0;

      let sumMonthOutcome = 0;

      accList.forEach((acc) => {

      })

      return sumMonthOutcome;
    }

    const accList = getMonthAccList('2025-08');
    console.log(sumMonthIncome(accList));

  </script>
</body>

</html>

