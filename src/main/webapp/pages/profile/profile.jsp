<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--  user 정보 여부에 따라서 회원가입(회원정보가 아직 없음) | 도서등록(회원 정보 있음) 양갈래로 유도한다..-->    
<!DOCTYPE html>
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Skydash Admin</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="/vendors/feather/feather.css">
  <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="../../js/select.dataTables.min.css">
    <link rel="stylesheet" href="/css/vertical-layout-light/style.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="/images/favicon.png" />
   <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.col-width-1 { width: 40%; } 
	.col-width-2 { width: 40%; }
	.col-width-3 { width: 20%; }


	th{
		height: 30px !important;
		padding:0 !important;
	}
	td{
		block-size: 40px !important;
		height: 40px !important;
		padding-top: 0 !important;
		padding-bottom: 0 !important;
		font-family: 'Jua', sans-serif;
		font-size: 33px;
	}

	h3{
		font-family: 'Jua', sans-serif;
	}
	h4{
		font-family: 'Jua', sans-serif;
		
	}
	
	form h4{
		margin-top:20px;
	}
	.hide-scrollbar::-webkit-scrollbar {
    width: 0;
    background: transparent;
	}   

	#profileContainer{
		width: 120px; 
		height: 120px; 
		border: 1px solid black;
		border-radius: 50%; 
		background-color: #ccc; 
		color: #888; 
		display: flex; 
		
		font-size: 16px; 
		cursor: pointer;
		user-select: none;
		display: flex; 
    flex-direction: column; /* 추가 */
    justify-content: center; 
    align-items: center; 
    text-align: center; /* 추가 */
    line-height: 1.2;
			  
	}
	#initMemBtn{
	
	}
</style>
<script>
$(() => {
	let timeoutId;
	
    // 닉네임 입력 시 검색
    $('#nicknameInput').on('input', function() {
        clearTimeout(timeoutId);
        const keyword = $(this).val().trim();

        if (keyword.length < 2) {
            $('#addFriendResultTable').empty();
            return;
        }

        timeoutId = setTimeout(() => {
            $.ajax({
                url: '/searchMembers',
                type: 'POST',
                data: { nickname: keyword },
                success: function(data) {
                    if (data.length === 0) {
                        $('#addFriendResultTable').html('<tr><td colspan="3">검색 결과가 없습니다.</td></tr>');
                        return;
                    }

                    let html = '';

                    data.forEach(function(member) {
                        html += '<tr data-id="' + member.memId + '">' +
                                    '<td><img src="' + (member.profile_img || 'default.png') + '" alt="프로필" width="40" height="40" style="border-radius:50%;"></td>' +
                                    '<td>' + member.nickname + '#' + member.memId + '</td>' +
                                    '<td>' + member.email + '</td>' +
                                    '<td>' +
                                    '<form action="/addFriend" method="POST">' +
                                    '<input type="hidden" name="friendId" value="' + member.memId + '">' +
                                    '<button type="submit" style=" width:75px;height:30px;color:white;background-color: #7A5EE7;border: none; border-radius: 10px">친구 추가</button>' +
                                  '</form>' + '</td>'
                                '</tr>';
                    });

                    html += '</tbody>';

                    $('#addFriendResultTable').html(html);
                },
                error: function() {
                    alert('검색 중 오류가 발생했습니다.');
                }
            });
        }, 300); // 300ms 딜레이
    });

	
	$('#profileContainer').on('click', function () {
        $('#fileInput').click();
    });

    // 파일 선택 시 미리보기
    $('#fileInput').on('change', function (e) {
    	var file = e.target.files[0];
    	if (!file) return;

    	var reader = new FileReader();
	    reader.onload = function (event) {
	        $('#profileContainer')
	            .css({
	                'background-image': 'url(' + event.target.result + ')',
	                'background-size': 'cover',        // 가득 채우기
	                'background-position': 'center',   // 중앙 정렬
	                'background-repeat': 'no-repeat',  // 반복 없음
	                'border-radius': '50%'              // 동그랗게
	            })
	            .text(''); // 기존 텍스트 제거
	    };
	    reader.readAsDataURL(file);
	});
});
</script>
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
                <div class="profile"><img src="/images/faces/face1.jpg" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Thomas Douglas</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">19 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="/images/faces/face2.jpg" alt="image"><span class="offline"></span></div>
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
                <div class="profile"><img src="/images/faces/face3.jpg" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Daniel Russell</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">14 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="/images/faces/face4.jpg" alt="image"><span class="offline"></span></div>
                <div class="info">
                  <p>James Richardson</p>
                  <p>Away</p>
                </div>
                <small class="text-muted my-auto">2 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="/images/faces/face5.jpg" alt="image"><span class="online"></span></div>
                <div class="info">
                  <p>Madeline Kennedy</p>
                  <p>Available</p>
                </div>
                <small class="text-muted my-auto">5 min</small>
              </li>
              <li class="list">
                <div class="profile"><img src="/images/faces/face6.jpg" alt="image"><span class="online"></span></div>
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
        	<div class="wrapper"  style="width:1000px; height:100%; margin:0 auto">
         		<div class="card tale-bg"  style="background:white;height:300px;">
	                <div class="card-body" style="padding:20px;padding-bottom:0;">
	                		<h3>친구 추가</h3>
	               	</div>
	               	<div class="card-body" style="width:70%; margin:0 auto">
	               		<form action="#">
	               			<input type="text" id="nicknameInput" placeholder="등록할 친구의 닉네임을 입력해주세요." style="width: 100%;height:45px;background:#F5F7F9;border:none;border-radius:15px;font-size:15px;padding-left:20px" required>
	               		</form>
		                <div class="hide-scrollbar" style="height: 200px; overflow-y: scroll;">
		                	<div class="card-body">
			                	<table id="addFriendResultTable" class="table table-hover" style=" text-align: center;">
				                	
								</table>
							</div>
		                </div>
	                </div>
              	</div>
              	<c:choose>
              		<c:when test="${not empty friendPendingList}">
              			<div class="card tale-bg"  style="background:white; margin-top: 40px">
              				<div class="card-body">
              				<h3>친구 요청</h3>
	              		<div class="acceptFriendTable">
	              		<table class="table table-hover" style="text-align: center;">
	              			<tbody>
	              			<c:forEach items="${friendPendingList}" var="friend">
	              				<tr>
									<td class="col-width-1" style="height:40px">${friend.nickname} #${friend.memId}</td>
									<td class="col-width-2" style="height:40px">${friend.email}</td>
									<td class="col-width-3" style="height:40px">
										<div class="row">
										<form action="acceptFriend" method="POST">
											<input type="hidden" name="friendId" value="${friend.memId}">
											<input type="submit" value="수락" style="width:40px;height:30px;margin-right:20px;color:white;background-color: #7A5EE7;border: none; border-radius: 10px">
										</form>
										<form action="deleteFriend" method="POST">
											<input type="hidden" name="friendId" value="${friend.memId}">
											<input type="submit" value="거부" style="width:40px;height:30px;margin-right:20px;color:white;background-color: #FF4752;border: none; border-radius: 10px">
										</form>
										</div>
									</td>
								</tr>
	              			</c:forEach>
	              			</tbody>
	              			</table>
	              			</div>
						</div>
						</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
              	<div class="card tale-bg"  style="margin-top:40px; background:white;width:100%; height:300px;">
              		<div class="card-body">
              			<h3>친구 목록</h3>
              			<div style ="width: 80%; margin: 0 auto">
	              			<div class="hide-scrollbar" style="height: 200px; overflow-y: scroll;">
			                	<div class="card-body" style="margin-top: 0;">
			                		
				                	<table class="table table-hover" style=" text-align: center;">
				                		<tbody>
					                	<c:forEach items="${friendList}" var="friend">				
											<tr>
											   	<td class="col-width-1" style="height:40px">${friend.nickname} #${friend.memId}</td>
												<td class="col-width-2" style="height:40px">${friend.email}</td>
												<td class="col-width-3" style="height:40px">
													<form action="deleteFriend" method="POST">
														<input type="hidden" name="friendId" value="${friend.memId}">
														<input type="submit" value="삭제" style="width:75px;height:30px;margin-right:20px;color:white;background-color: #7A5EE7;border: none; border-radius: 10px">
													</form>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
			                </div>
		                </div>
              		</div>
              	</div>
              	<div class="card tale-bg"  style="margin-top:40px; background:white;width:100%; height:650px;">
              		<div class="card-body">
              			<h3>회원 정보 수정</h3>
              			<form id="updateMember" action="updateMember">
              			<div class="profile-img-box" style="width:100%;height:120px">
              				<div class="profile-img" style="width:120px; height: 120px; margin: 0 auto">
	             				<div id="profileContainer">
									  프로필<br>이미지
								</div>
							
								<!-- 숨겨진 파일 선택 input -->
								<input type="file" name="profileImage" id="fileInput" accept="image/*" style="display:none;">
							</div>
              			</div>
              			<div class="card-body">
              				<h4>E-Mail</h4>
              				<input type="text" name="eMail" id="eMail"  placeholder="E-Mail주소를 입력해주세요." style="width: 100%;height:45px;background:#F5F7F9;border:none;border-radius:15px;font-size:15px;padding-left:20px" required>
              				<h4 style="margin-top:20px">비밀번호</h4>
              				<input type="password" name="password" id="password" placeholder="변경할 password를 입력해주세요." style="width: 100%;height:45px;background:#F5F7F9;border:none;border-radius:15px;font-size:15px;padding-left:20px" required>
              				<h4 style="margin-top:20px">비밀번호 확인</h4>
              				<input type="password" name="passwordConfirm" id="password-confirm" placeholder="변경할 password를 입력해주세요." style="width: 100%;height:45px;background:#F5F7F9;border:none;border-radius:15px;font-size:15px;padding-left:20px" required>
              				<div class="row" style="margin-top:20px">
              					<div class="col-md-6 grid-margin stretch-card">
              						<div style="width:100%">
	              						<h4>닉네임</h4>
	              						<input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력해주세요." style="width: 100%;height:45px;background:#F5F7F9;border:none;border-radius:15px;font-size:15px;padding-left:20px" required>
	              					</div>
              					</div>
              					<div class="col-md-6 grid-margin stretch-card">
	              					<div style="width:100%">
	              						<h4>성별</h4>
	              						<input type="text" name="gender" id="gender" placeholder="성별을 선택해주세요." style="width: 100%;height:45px;background:#F5F7F9;border:none;border-radius:15px;font-size:15px;padding-left:20px" required>
	              					</div>
              					</div>
              				</div>
              				<div class="row" style="justify-content: flex-end;">
              					<input type="reset" id="initMemBtn" style="width:75px;height:40px;margin-right:20px;background-color:white;border-radius: 10px;" value="초기화">
              					<input type="submit" id="updateBtn" value="수정" style="width:75px;height:40px;margin-right:20px;color:white;background-color: #7A5EE7;border: none; border-radius: 10px">
              				</div>
              			</div>
              			</form>
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
  <script src="/js/off-canvas.js"></script>
  <script src="/js/hoverable-collapse.js"></script>
  <script src="/js/template.js"></script>
  <script src="/js/settings.js"></script>
  <script src="/js/todolist.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <script src="/js/dashboard.js"></script>
  <script src="/js/Chart.roundedBarCharts.js"></script>
  <!-- End custom js for this page-->
</body>

</html>