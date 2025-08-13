<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="ko_KR"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Skydash Admin</title>

  <!-- plugins:css -->
  <!-- Google Fonts Jua -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Jua&display=swap">
  
  <link rel="stylesheet" href="<c:url value='/vendors/feather/feather.css'/>">
  <link rel="stylesheet" href="<c:url value='/vendors/ti-icons/css/themify-icons.css'/>">
  <link rel="stylesheet" href="<c:url value='/vendors/css/vendor.bundle.base.css'/>">
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="<c:url value='/vendors/datatables.net-bs4/dataTables.bootstrap4.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/js/select.dataTables.min.css'/>">
  <!-- inject:css -->
  <link rel="stylesheet" href="<c:url value='/css/vertical-layout-light/style.css'/>">
  <!-- endinject -->
  <link rel="shortcut icon" href="<c:url value='/images/favicon.png'/>" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
  
  <style>
    body {
    font-family: 'Jua', sans-serif;
  }
  
  #schedulePickerModal .modal-dialog{ max-width:370px; }
  #schedulePickerModal .flatpickr-calendar.inline{
    box-shadow:none;border:none;width:100%;
  }
  .todo-meta { margin-top: .25rem; }
  
</style>
  
</head>
<body>
  <div class="container-scroller">
    <!-- Header (상단 네비) -->
    <jsp:include page="/components/header.jsp"/>

    <div class="container-fluid page-body-wrapper">
      <!-- 오른쪽 설정 패널 (필요 시 유지) -->
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
                <div class="profile"><img src="<c:url value='/images/faces/face1.jpg'/>" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Thomas Douglas</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">19 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face2.jpg'/>" alt="image"><span class="offline"></span></div>
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
                <div class="profile"><img src="<c:url value='/images/faces/face3.jpg'/>" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Daniel Russell</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">14 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face4.jpg'/>" alt="image"><span class="offline"></span></div>
                <div class="info">
                  <p>James Richardson</p>
                  <p>Away</p>
                </div>
                <small class="text-muted my-auto">2 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face5.jpg'/>" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Madeline Kennedy</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">5 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face6.jpg'/>" alt="image"><span class="online"></span></div>
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

      <!-- Sidebar (좌측 사이드) -->
      <jsp:include page="/components/navbar.jsp"/>

      <!-- ✅ 본문 래퍼 -->
      <div class="main-panel">
<div class="content-wrapper">
  <div class="row justify-content-center">
    <div class="col-md-12 grid-margin stretch-card">
      <div class="card">
        <div class="card-body" style="height:750px;">
          <h4 class="card-title">할일</h4>

          <!-- 스크롤 영역: 카드 높이보다 크지 않게 -->
          <div class="list-wrapper pt-2" style="max-height: 600px; overflow-y: auto;">
            <ul class="d-flex flex-column-reverse todo-list todo-list-custom">
              <c:forEach var="todo" items="${todoList}">
                <li data-id="${todo.todoId}" class="${todo.todoDone ? 'completed' : ''}">
                  <div class="form-check form-check-flat">
                    <label class="form-check-label">
                      <input class="checkbox js-toggle" type="checkbox" ${todo.todoDone ? 'checked' : ''}>
                      ${fn:escapeXml(todo.todoContent)}
                    </label>
                  </div>
                  
                    <!-- ✅ 날짜/시간 줄 -->
			      <div class="todo-meta text-muted small pl-4">
			      <!-- todoTime 컬럼이 있다면 날짜+시간 -->
			        <c:choose>
			          <c:when test="${not empty todo.todoTime}">
			            <fmt:formatDate value="${todo.todoDate}" pattern="M월 d일 (E)"/>
			            &nbsp;
			            <span>
			              <c:set var="hh" value="${fn:substring(todo.todoTime,0,2)}"/>
			              <c:set var="mm" value="${fn:substring(todo.todoTime,3,5)}"/>
			              <c:choose>
			                <c:when test="${hh >= 12}">오후 ${hh == 12 ? 12 : hh-12}시${mm != '00' ? mm.concat('분') : ''}</c:when>
			                <c:otherwise>오전 ${hh == 0 ? 12 : hh}시${mm != '00' ? mm.concat('분') : ''}</c:otherwise>
			              </c:choose>
			            </span>
			          </c:when>
			          <c:otherwise>
			            <fmt:formatDate value="${todo.todoDate}" pattern="M월 d일 (E)"/>
			          </c:otherwise>
			        </c:choose>
			      </div>
      
                  <i class="remove ti-close js-delete" title="삭제"></i>
                </li>
              </c:forEach>
            </ul>
          </div>

          <!-- 추가 폼 -->
          
		<div class="add-items d-flex mb-0 mt-2 align-items-center">
		
		  <input type="text" id="todoText" class="form-control todo-list-input" placeholder="□ 할일 추가">
		  <div class="form-check ml-2">
		  </div>
		
		  <button class="add btn btn-icon text-primary todo-list-add-btn bg-transparent ml-2">
		    <i class="icon-circle-plus"></i>
		  </button>
		
		  <!-- 모달에서 선택한 값이 들어갈 숨김 필드 -->
		  <input type="hidden" id="todoDate">
		  <input type="hidden" id="todoTime">
		  <input type="hidden" id="todoRepeat">
		</div>
		
        </div>
      </div>
    </div>
  </div> <!-- row -->
</div> <!-- content-wrapper -->

<!--  모달 마크업 -->
<div class="modal fade" id="schedulePickerModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content p-2">
      <div class="modal-body">
        <div id="todoPickerCal"></div>

        <div class="mt-3">
          <label class="font-weight-bold mb-1">시간 설정</label>
          <input type="time" id="todoPickerTime" class="form-control">
        </div>

        <div class="mt-3">
          <label class="font-weight-bold mb-1">반복</label>
          <select id="todoRepeatSelect" class="form-control">
            <option value="NONE">없음</option>
            <option value="DAILY">매일</option>
            <option value="WEEKLY">매주</option>
            <option value="MONTHLY">매월</option>
          </select>
        </div>

        <div class="d-flex justify-content-between mt-3">
          <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
          <button type="button" id="schedulePickerOk" class="btn btn-primary">완료</button>
        </div>
      </div>
    </div>
  </div>
</div>	<!--  모달 -->

        <!-- Footer -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">
              Copyright © 2021.  Premium
              <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a>
              from BootstrapDash. All rights reserved.
            </span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">
              Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i>
            </span>
          </div>
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">
              Distributed by <a href="https://www.themewagon.com/" target="_blank">Themewagon</a>
            </span>
          </div>
        </footer>
      </div> <!-- main-panel -->
    </div> <!-- page-body-wrapper -->
  </div> <!-- container-scroller -->

  <!-- plugins:js -->
  <script src="<c:url value='/vendors/js/vendor.bundle.base.js'/>"></script>
  <!-- Plugin js for this page -->
  <script src="<c:url value='/vendors/chart.js/Chart.min.js'/>"></script>
  <script src="<c:url value='/vendors/datatables.net/jquery.dataTables.js'/>"></script>
  <script src="<c:url value='/vendors/datatables.net-bs4/dataTables.bootstrap4.js'/>"></script>
  <script src="<c:url value='/js/dataTables.select.min.js'/>"></script>

  <!-- inject:js -->
  <script src="<c:url value='/js/off-canvas.js'/>"></script>
  <script src="<c:url value='/js/hoverable-collapse.js'/>"></script>
  <script src="<c:url value='/js/template.js'/>"></script>
  <script src="<c:url value='/js/settings.js'/>"></script>
  <script src="<c:url value='/js/todolist.js'/>"></script>
  <!-- Custom js for this page-->
  <script src="<c:url value='/js/dashboard.js'/>"></script>
  <script src="<c:url value='/js/Chart.roundedBarCharts.js'/>"></script>
  <script>
  // 캘린더 초기화
  let cal;
  $(function () {
    cal = flatpickr("#todoPickerCal", {
      inline: true,
      locale: 'ko',
      defaultDate: new Date()
    });

    // 아이콘 클릭 -> 모달 열기
    $("#openSchedulePicker").on("click", function(){
      $("#schedulePickerModal").modal("show");
    });

    // 완료 -> 숨김필드 채우고 모달 닫기
    $("#schedulePickerOk").on("click", function(){
      const d = cal.selectedDates[0] || new Date();
      const yyyy = d.getFullYear();
      const mm   = String(d.getMonth()+1).padStart(2,'0');
      const dd   = String(d.getDate()).padStart(2,'0');

      const dateStr = `${yyyy}-${mm}-${dd}`;    // yyyy-MM-dd
      const timeStr = $("#todoPickerTime").val(); // HH:mm or ""

      $("#todoDate").val(dateStr);
      $("#todoTime").val(timeStr || "");
      $("#todoRepeat").val($("#todoRepeatSelect").val());

      // 선택 내용을 placeholder에 살짝 보여주기
      const label = timeStr ? `${dateStr} ${timeStr}` : dateStr;
      $("#todoText").attr("placeholder", `할일 추가 — ${label}`);

      $("#schedulePickerModal").modal("hide");
    });
  });

  // ⬇️ 기존 “추가” 로직에 선택값을 포함해서 전송
	function addTodoFromInput() {
	  const text = $("#todoText").val().trim();
	  if (!text) return;
	
	  const rawDate = $("#todoDate").val();     // "", "2025-08-12", "--" 등
	  const rawTime = $("#todoTime").val();     // "", "18:09", "18:09:00", "--:--" 등
	
	  // "--" / "--:--" 같은 표시값은 버리고, 비면 기본값 적용
	  const date = (rawDate && rawDate !== "--")
	      ? rawDate
	      : new Date().toISOString().slice(0,10);
	
	  // 초는 안 보낼 거면 여기서 정규화
	  let time = (rawTime && rawTime !== "--:--") ? rawTime : null;
	  if (time && time.length === 8) time = time.slice(0,5); // "HH:mm:ss" -> "HH:mm"
	
	  const payload = {
	    todoContent: text,
	    todoDate: date,      // 항상 "yyyy-MM-dd"
	    todoTime: time,      // "HH:mm" 또는 null
	    todoImportant: $("#todoImportant").is(":checked")
	  };
	
	  $.ajax({
	    url: '/todo/add',
	    method: 'POST',
	    contentType: 'application/json',
	    data: JSON.stringify(payload),
	    success: () => location.reload()
	  });
	}

  // 엔터로 추가 + 버튼으로 추가
  $(".todo-list-input").on("keydown", function(e){
    if(e.key === "Enter"){
      e.preventDefault();
      addTodoFromInput();
    }
  });
  $(".todo-list-add-btn").on("click", function(e){
    e.preventDefault();
    addTodoFromInput();
  });
  
//체크박스 완료 토글 → 서버에 반영
  $(document).on('change', '.js-toggle', function () {
    const $cb = $(this);
    const todoId = $cb.data('id') || $cb.closest('li').data('id');
    const done = $cb.is(':checked');

    $.ajax({
      url: '/todo/done',
      method: 'POST',
      // @RequestParam 으로 받으므로 urlencoded 전송
      data: { todoId: todoId, done: done },
      success: function (res) {
        if (!res || res.success !== true) {
          // 실패 시 UI 되돌림
          $cb.prop('checked', !done);
          alert('저장에 실패했습니다.');
        }
      },
      error: function () {
        $cb.prop('checked', !done);
        alert('통신 오류가 발생했습니다.');
      }
    });
  });


//삭제 아이콘 클릭 → 서버 삭제 → UI에서 제거
  $(document).on('click', '.js-delete', function (e) {
    e.preventDefault();
    e.stopPropagation();

    const $li   = $(this).closest('li');
    const todoId = $li.data('id');

    if (!todoId) return;

    if (!confirm('이 할 일을 삭제할까요?')) return;

    $.ajax({
      url: '/todo/delete',
      method: 'POST',             // 컨트롤러가 @PostMapping("/delete")이므로 POST로 전송
      data: { todoId: todoId },   // @RequestParam int todoId 로 매핑됨
      // ⚠️ Spring Security 사용 시 CSRF 헤더 추가:
      // beforeSend: function(xhr){
      //   const token = $('meta[name="_csrf"]').attr('content');
      //   const header = $('meta[name="_csrf_header"]').attr('content');
      //   if (token && header) xhr.setRequestHeader(header, token);
      // },
      success: function (res) {
        // 컨트롤러가 {success:true, deleted:n} 형태로 반환
        if (res && (res.success === true || (res.deleted && res.deleted > 0))) {
          $li.slideUp(150, function(){ $(this).remove(); });
        } else {
          alert('삭제에 실패했습니다.');
        }
      },
      error: function () {
        alert('삭제 중 오류가 발생했습니다.');
      }
    });
  });


  console.log('payload', payload);
  $.ajax({ url:'/todo/add', method:'POST', contentType:'application/json', data: JSON.stringify(payload) });

</script>

</body>
</html>
