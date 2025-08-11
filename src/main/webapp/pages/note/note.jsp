<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Skydash Admin</title>

  <!-- plugins:css -->
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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    .card-white { background-color: #ffffff; }
    .favorite-toggle { font-size: 20px; cursor: pointer; color: black; }
    .clickable-icon { cursor: pointer; padding: 5px; border-radius: 5px; transition: background-color .2s; }
    .clickable-icon:hover { background-color: #f0f0f0; }
  </style>
</head>
<body>
  <div class="container-scroller">
    <!-- 공통 헤더 -->
    <jsp:include page="/components/header.jsp"/>

    <div class="container-fluid page-body-wrapper">
      <!-- (선택) 설정 패널 + 우측 사이드바 템플릿 유지 -->
      <div class="theme-setting-wrapper">
        <div id="settings-trigger"><i class="ti-settings"></i></div>
        <div id="theme-settings" class="settings-panel">
          <i class="settings-close ti-close"></i>
          <p class="settings-heading">SIDEBAR SKINS</p>
          <div class="sidebar-bg-options selected" id="sidebar-light-theme"><div class="img-ss rounded-circle bg-light border mr-3"></div>Light</div>
          <div class="sidebar-bg-options" id="sidebar-dark-theme"><div class="img-ss rounded-circle bg-dark border mr-3"></div>Dark</div>
          <p class="settings-heading mt-2">HEADER SKINS</p>
          <div class="color-tiles mx-0 px-4">
            <div class="tiles success"></div><div class="tiles warning"></div>
            <div class="tiles danger"></div><div class="tiles info"></div>
            <div class="tiles dark"></div><div class="tiles default"></div>
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
                      <input class="checkbox" type="checkbox"> Team review meeting at 3.00 PM
                    </label>
                  </div>
                  <i class="remove ti-close"></i>
                </li>
                <li>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox"> Prepare for presentation
                    </label>
                  </div>
                  <i class="remove ti-close"></i>
                </li>
                <li>
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox"> Resolve all the low priority tickets due today
                    </label>
                  </div>
                  <i class="remove ti-close"></i>
                </li>
                <li class="completed">
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox" checked> Schedule meeting for next week
                    </label>
                  </div>
                  <i class="remove ti-close"></i>
                </li>
                <li class="completed">
                  <div class="form-check">
                    <label class="form-check-label">
                      <input class="checkbox" type="checkbox" checked> Project review
                    </label>
                  </div>
                  <i class="remove ti-close"></i>
                </li>
              </ul>
            </div>
            <h4 class="px-3 text-muted mt-5 font-weight-light mb-0">Events</h4>
            <div class="events pt-4 px-3">
              <div class="wrapper d-flex mb-2"><i class="ti-control-record text-primary mr-2"></i><span>Feb 11 2018</span></div>
              <p class="mb-0 font-weight-thin text-gray">Creating component page build a js</p>
              <p class="text-gray mb-0">The total number of sessions</p>
            </div>
            <div class="events pt-4 px-3">
              <div class="wrapper d-flex mb-2"><i class="ti-control-record text-primary mr-2"></i><span>Feb 7 2018</span></div>
              <p class="mb-0 font-weight-thin text-gray">Meeting with Alisa</p>
              <p class="text-gray mb-0 ">Call Sarah Graves</p>
            </div>
          </div>

          <div class="tab-pane fade" id="chats-section" role="tabpanel" aria-labelledby="chats-section">
            <div class="d-flex align-items-center justify-content-between border-bottom">
              <p class="settings-heading border-top-0 mb-3 pl-3 pt-0 border-bottom-0 pb-0">Friends</p>
              <small class="settings-heading border-top-0 mb-3 pt-0 border-bottom-0 pb-0 pr-3 font-weight-normal">See All</small>
            </div>
            <ul class="chat-list">
              <li class="list active">
                <div class="profile"><img src="<c:url value='/images/faces/face1.jpg'/>" alt="image"><span class="online"></span></div>
                <div class="info"><p>Thomas Douglas</p><p>Available</p></div>
                <small class="text-muted my-auto">19 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face2.jpg'/>" alt="image"><span class="offline"></span></div>
                <div class="info"><div class="wrapper d-flex"><p>Catherine</p></div><p>Away</p></div>
                <div class="badge badge-success badge-pill my-auto mx-2">4</div>
                <small class="text-muted my-auto">23 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face3.jpg'/>" alt="image"><span class="online"></span></div>
                <div class="info"><p>Daniel Russell</p><p>Available</p></div>
                <small class="text-muted my-auto">14 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face4.jpg'/>" alt="image"><span class="offline"></span></div>
                <div class="info"><p>James Richardson</p><p>Away</p></div>
                <small class="text-muted my-auto">2 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face5.jpg'/>" alt="image"><span class="online"></span></div>
                <div class="info"><p>Madeline Kennedy</p><p>Available</p></div>
                <small class="text-muted my-auto">5 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="<c:url value='/images/faces/face6.jpg'/>" alt="image"><span class="online"></span></div>
                <div class="info"><p>Sarah Graves</p><p>Available</p></div>
                <small class="text-muted my-auto">47 min</small>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <!-- 공통 좌측 네비게이션 -->
      <jsp:include page="/components/navbar.jsp"/>

      <!-- 메인 -->
      <div class="main-panel">
        <div class="content-wrapper">
          <!-- 입력 카드 -->
          <div class="row justify-content-center">
            <div class="col-md-8 grid-margin transparent">
              <div class="card card-white p-4 text-secondary position-relative" style="height:250px;">
                <div class="d-flex justify-content-between align-items-start">
                  <input type="text" class="form-control form-control-sm text-secondary"
                         placeholder="제목" id="noteName"
                         style="border:none; box-shadow:none; font-size:1.25rem; font-weight:bold;">
                </div>
                <div class="d-flex justify-content-between align-items-start">
                  <textarea class="form-control form-control-sm text-secondary"
                            placeholder="메모 작성" id="noteContent"
                            rows="5"
                            style="border:none; box-shadow:none; resize:none;"></textarea>
                </div>
                <div class="d-flex justify-content-between align-items-start">
                  <button id="saveBtn" class="btn btn-sm btn-outline-primary mt-3 mr-3 position-absolute"
                          style="bottom:1.5rem; right:1rem;">저장</button>
                </div>
              </div>
            </div>
          </div>

          <!-- 필터 + 목록 -->
          <div class="col-md-12 grid-margin transparent">
            <div class="d-flex align-items-center mb-2">
              <input type="checkbox" id="favOnly" class="mr-2">
              <label for="favOnly" class="mb-0">즐겨찾기만 보기</label>
            </div>
            <div class="row notes-container"></div>
          </div>
        </div>

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
      </div>
    </div>
  </div>

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
  <script src="<c:url value='/js/dashboard.js'/>"></script>
  <script src="<c:url value='/js/Chart.roundedBarCharts.js'/>"></script>

  <script>
    let editingNoteId = null;

    $(function () {
      // 세션에서 가져오고, 없으면 1로(default) 사용
      const memId = <c:out value="${sessionScope.member.memId}" default="1"/>;

      // 목록 로딩
      function loadNotes() {
        const favOnly = $('#favOnly').is(':checked');
        $.ajax({
          url: '<c:url value="/note/list"/>',
          method: 'GET',
          data: { memId: memId, important: favOnly },
          success: function (noteList) { renderNoteList(noteList || []); },
          error: function () { alert('메모 목록 불러오기 실패'); }
        });
      }

      // 렌더링
      function renderNoteList(noteList) {
        const $container = $('.notes-container').empty();
        noteList.forEach(note => {
          const $col  = $('<div class="col-md-3 mb-4 stretch-card transparent"></div>');
          const $card = $('<div class="card card-white position-relative" style="aspect-ratio:1/1; max-width:315px;"></div>')
                         .attr('data-note-id', note.noteId);

          // 즐겨찾기
          $('<i class="favorite-toggle bi position-absolute mt-3 mr-3"></i>')
            .addClass(note.noteImportant ? 'bi-star-fill' : 'bi-star')
            .attr('data-fav', String(!!note.noteImportant))
            .css({ top:'0.1rem', right:0, margin:'1rem' })
            .appendTo($card);

          // 본문
          const $body = $('<div class="card-body"></div>').css({
            maxHeight: '250px',
            overflow: 'auto',
            paddingBottom: '2.5rem'
          }).appendTo($card);

          $('<p class="mb-2 note-title" style="font-size:1.25rem;font-weight:bold;white-space:normal;overflow-wrap:anywhere;color:black;"></p>')
            .text(note.noteName || '')
            .appendTo($body);

          $('<p class="mb-3 note-content" style="font-size:1rem;white-space:normal;overflow-wrap:anywhere;color:black;"></p>')
            .text(note.noteContent || '')
            .appendTo($body);

          // 액션
          const $actions = $('<div class="mt-3 d-flex position-absolute" style="bottom:.75rem; right:.75rem; margin:1rem;"></div>')
                            .appendTo($card);
          $('<i class="bi bi-pencil clickable-icon" title="수정" data-action="edit"></i>').appendTo($actions);
          $('<i class="bi bi-trash clickable-icon" title="삭제"></i>')
            .on('click', () => deleteNote(note.noteId))
            .appendTo($actions);

          $container.append($col.append($card));
        });
      }

      // 즐겨찾기 토글
      $(document).on('click', '.favorite-toggle', function () {
        const $icon = $(this);
        if ($icon.data('busy')) return;
        $icon.data('busy', true);

        const noteId = parseInt($icon.closest('[data-note-id]').attr('data-note-id'), 10);
        const next   = !($icon.attr('data-fav') === 'true');

        $.ajax({
          type: 'POST',
          url: '<c:url value="/note/important"/>',
          contentType: 'application/json',
          data: JSON.stringify({ noteId: noteId, noteImportant: next ? 1 : 0 }),
          success: function (res) {
            const ok = (typeof res === 'number') ? (res > 0) : (res && res.success);
            if (!ok) { alert('즐겨찾기 변경 실패'); return; }

            if ($('#favOnly').is(':checked')) {
              loadNotes(); // 필터 ON이면 재로딩
            } else {
              if (next) $icon.removeClass('bi-star').addClass('bi-star-fill').attr('data-fav','true');
              else $icon.removeClass('bi-star-fill').addClass('bi-star').attr('data-fav','false');
            }
          },
          error: function () { alert('서버 오류로 즐겨찾기 변경 실패'); },
          complete: function () { $icon.data('busy', false); }
        });
      });

      // 필터
      $('#favOnly').on('change', loadNotes);

      // 수정 아이콘
      $(document).on('click', '.clickable-icon[data-action="edit"]', function () {
        const $card = $(this).closest('[data-note-id]');
        const noteId = parseInt($card.attr('data-note-id'), 10);
        const title = $card.find('.note-title').text().trim();
        const content = $card.find('.note-content').text().trim();

        $('#noteName').val(title);
        $('#noteContent').val(content);
        editingNoteId = noteId;
        $('#saveBtn').text('수정완료');
      });

      // 저장/수정
      $('#saveBtn').on('click', function () {
        const title = $('#noteName').val().trim();
        const content = $('#noteContent').val().trim();
        if (!title || !content) { alert('제목과 내용을 입력해주세요.'); return; }

        if (editingNoteId !== null) {
          $.ajax({
            type: 'PUT',
            url: '<c:url value="/note/updateNote"/>',
            contentType: 'application/json',
            data: JSON.stringify({ noteId: Number(editingNoteId), noteName: title, noteContent: content }),
            success: function (res) {
              if (!res || !res.success) { alert('수정 0건'); return; }
              alert('메모 수정 완료!');
              resetForm(); loadNotes();
            },
            error: function () { alert('수정 실패'); }
          });
        } else {
          $.ajax({
            type: 'POST',
            url: '<c:url value="/note/addNote"/>',
            contentType: 'application/json',
            data: JSON.stringify({ noteName: title, noteContent: content }),
            success: function () {
              alert('메모가 저장되었습니다!');
              resetForm(); loadNotes();
            },
            error: function () { alert('메모 저장 실패'); }
          });
        }
      });

      // 삭제
      function deleteNote(noteId) {
        if (!confirm('이 메모를 삭제할까요?')) return;
        $.ajax({
          type: 'POST',
          url: '<c:url value="/note/delete"/>',
          data: { noteId: noteId },
          success: function (deletedCount) {
            if (Number(deletedCount) > 0) {
              if (editingNoteId === noteId) resetForm();
              loadNotes();
              alert('삭제 완료!');
            } else {
              alert('삭제 0건 (이미 삭제되었거나 ID가 잘못됨)');
            }
          },
          error: function () { alert('삭제 실패. 잠시 후 다시 시도해주세요.'); }
        });
      }

      function resetForm() {
        editingNoteId = null;
        $('#noteName').val('');
        $('#noteContent').val('');
        $('#saveBtn').text('저장');
      }

      // 초기 로딩
      loadNotes();
    });
  </script>
</body>
</html>
