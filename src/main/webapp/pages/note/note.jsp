<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <link rel="shortcut icon" href="<c:url value="/images/favicon.png"/>"/>

    <style>
        .card-white {
            background-color: #ffffff; /* 흰색 배경 */
        }

        .favorite-toggle {
            font-size: 20px;
            cursor: pointer;
            color: black;
        }

        .clickable-icon {
            cursor: pointer; /* 마우스 포인터 손가락 모양 */
            padding: 5px; /* 클릭 가능한 범위 확장 */
            border-radius: 5px; /* 약간 둥글게 */
            transition: background-color 0.2s;
        }

        .clickable-icon:hover {
            background-color: #f0f0f0; /* 호버 시 배경 강조 */
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
                <div class="row justify-content-center">
                    <div class="col-md-8 grid-margin transparent">
                        <div class="card card-white p-4 text-secondary position-relative" style="height:250px;">
                            <div class="d-flex justify-content-between align-items-start">
                                <input type="text" class="form-control form-control-sm text-secondary"
                                       placeholder="제목" id="noteName"
                                       style="border: none; box-shadow: none; font-size: 1.25rem; font-weight: bold;">
                            </div>
                            <div class="d-flex justify-content-between align-items-start">
                  <textarea class="form-control form-control-sm text-secondary"
                            placeholder="메모 작성" id="noteContent"
                            rows="5"
                            style="border: none; box-shadow: none; resize: none;"></textarea>
                            </div>
                            <div class="d-flex justify-content-between align-items-start ">

                                <button id="saveBtn" class="btn btn-sm btn-outline-primary mt-3 mr-3 position-absolute"
                                        style="bottom: 1.5rem; right: 1rem;">저장
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12 grid-margin transparent">
                    <div class="row notes-container">
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
<script src="vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<script src="vendors/chart.js/Chart.min.js"></script>
<script src="vendors/datatables.net/jquery.dataTables.js"></script>
<script src="vendors/datatables.net-bs4/dataTables.bootstrap4.js"></script>
<script src="js/dataTables.select.min.js"></script>

<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="js/off-canvas.js"></script>
<script src="js/hoverable-collapse.js"></script>
<script src="js/template.js"></script>
<script src="js/settings.js"></script>
<script src="js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<script src="js/dashboard.js"></script>
<script src="js/Chart.roundedBarCharts.js"></script>
<!-- End custom js for this page-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    let editingNoteId = null;

    $(document).ready(function () {
        const memId = 1;

        // 🔁 별 아이콘 클릭 (동적 바인딩)
        $(document).on('click', '.favorite-toggle', function () {
            const isFav = $(this).attr('data-fav') === 'true';
            if (isFav) {
                $(this).removeClass('bi-star-fill').addClass('bi-star');
                $(this).attr('data-fav', 'false');
            } else {
                $(this).removeClass('bi-star').addClass('bi-star-fill');
                $(this).attr('data-fav', 'true');
            }

            // TODO: 여기서 AJAX로 서버에 중요 여부 변경 요청도 보낼 수 있음
            // 예: /note/important
        });

        // 💾 저장 및 수정
        $('#saveBtn').click(function () {
            const title = $('#noteName').val().trim();
            const content = $('#noteContent').val().trim();

            if (title === '' || content === '') {
                alert('제목과 내용을 입력해주세요.');
                return;
            }

            if (editingNoteId !== null) {
                $.ajax({
                    type: 'PUT',
                    url: '/note/updateNote',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        noteId: editingNoteId,
                        noteName: title,
                        noteContent: content
                    }),
                    success: function () {
                        alert('메모 수정 완료!');
                        $('#noteName').val('');
                        $('#noteContent').val('');
                        $('#saveBtn').text('저장');
                        editingNoteId = null;
                        location.reload();
                    },
                    error: function () {
                        alert('수정 실패');
                    }
                });
            } else {
                $.ajax({
                    type: 'POST',
                    url: '/note/addNote',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        noteName: title,
                        noteContent: content
                    }),
                    success: function () {
                        alert('메모가 저장되었습니다!');
                        $('#noteName').val('');
                        $('#noteContent').val('');
                        location.reload();
                    },
                    error: function (xhr, status, error) {
                        alert('메모 저장 실패');
                        console.error(error);
                    }
                });
            }
        });

        // 📥 메모 리스트 불러오기
        $.ajax({
            url: '/note/list',
            method: 'GET',
            data: {memId: memId},
            success: function (noteList) {
                console.log("🔥 noteList 데이터 확인:", noteList); // 추가
                console.log(JSON.stringify(noteList, null, 2));

                // Ajax 성공 시, renderNoteList 함수를 호출하여 화면에 노트를 그립니다.
                renderNoteList(noteList);

                // ✅ DOM 렌더링 완료 후 확인용 로그
                setTimeout(() => {
                    console.log("카드 렌더링 후 노트 제목들:");
                    console.log('노트 개수:', $('.note-title').length);
                    $('.note-title').each(function () {
                        console.log('📘', $(this).text());
                    });
                }, 1000);
            },
            error: function () {
                alert('메모 목록 불러오기 실패');
            }
        });

        // 🔁 카드 렌더링 함수
        function renderNoteList(noteList) {
            const $container = $('.notes-container');
            $container.empty();


            noteList.forEach(note => {
                console.log('🧾 note 객체:', note);
                console.log('📌 note.noteName:', note.noteName);
                console.log('🎯 noteName:', note.noteName);

                const cardHtml = `
          <div class="col-md-3 mb-4 stretch-card transparent">
            <div class="card card-white position-relative" style="aspect-ratio: 1 / 1; max-width: 315px; " data-note-id="${note.noteId}">
              <i class="favorite-toggle bi ${note.noteImportant ? 'bi-star-fill' : 'bi-star'} position-absolute mt-3 mr-3" style="top:1; right:0; margin:1rem;" data-fav="${note.noteImportant}"></i>
              <div class="card-body">
	              <p class="mb-2 note-title" style="font-size: 1.25rem; font-weight: bold; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: black;">${note.noteName}</p>
	              <p class="mb-3 note-content" style="font-size: 1rem; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color:black;">${note.noteContent || '내용 없음'}${note.noteContent}</p>

              </div>
              <div class="mt-3 d-flex position-absolute" style="bottom:0.75rem; right:0.75rem; margin:1rem;">
                <i class="bi bi-pencil clickable-icon" title="수정" onclick="updateNote('${note.noteId}')"></i>
                <i class="bi bi-trash clickable-icon" title="삭제" onclick="deleteNote(${note.noteId})"></i>
              </div>
            </div>
          </div>
        `;
                $container.append(cardHtml);


            });
        }
    });

    // 🛠 수정 함수는 외부에 선언
    function updateNote(noteId) {
        const card = $(`[data-note-id="${noteId}"]`);
        const title = card.find('.note-title').text().trim();
        const content = card.find('.note-content').text().trim();

        $('#noteName').val(title);
        $('#noteContent').val(content);
        editingNoteId = noteId;
        $('#saveBtn').text('수정완료');
    }

</script>

</body>

</html>

