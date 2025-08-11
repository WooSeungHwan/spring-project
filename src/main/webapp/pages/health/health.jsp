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
  <link rel="stylesheet" href="vendors/feather/feather.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="js/select.dataTables.min.css">
    <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="images/favicon.png" />
   <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	.col-width-1 { width: 40%; }
	.col-width-2 { width: 27%; }
	.col-width-3 { width: 33%; }
	th{
		padding:0 !important;
	}
	td{
		font-family: 'Jua', sans-serif;
		font-size: 33px;
	}

	h3{
		font-family: 'Jua', sans-serif;
	}
	.hide-scrollbar::-webkit-scrollbar {
    width: 0;
    background: transparent;
	}   
	.underweight {
	  color: #3498db;
	}
	
	.normal {
	  color: #27ae60;
	}
	
	.overweight {
	  color: #f1c40f;
	}
	
	.obese {
	  color: #e74c3c;
	}
	#doughnutChart {
 	 width: 100% !important;
}
</style>
<script>
var doughnutChart;
$(() => {
	var doughnutPieData = {
		    datasets: [{
		      data: ${chartData},
		      backgroundColor: [
		        'rgba(122,94,231,0.5)',
		        'rgba(122,128,139,0.5)',
		        'rgba(255, 206, 86, 0.5)',
		        'rgba(75, 192, 192, 0.5)',
		        'rgba(153, 102, 255, 0.5)',
		        'rgba(255, 159, 64, 0.5)'
		      ],
		      borderColor: [
		        'rgba(122,94,231,1)',
		        'rgba(122,128,139,1)',
		        'rgba(255, 206, 86, 1)',
		        'rgba(75, 192, 192, 1)',
		        'rgba(153, 102, 255, 1)',
		        'rgba(255, 159, 64, 1)'
		      ],
		    }],
		    labels: [
		        <c:forEach var="label" items="${chartLabel}" varStatus="loop">
	            '${label}'
	            <c:if test="${!loop.last}">, </c:if>
	        </c:forEach>
	    	]
	};
	const centerTextPlugin = {
			  id: 'centerText',
			  afterDraw(chart) {
			    const { ctx, chartArea, data } = chart;
			    if (!chartArea) return;

			    const datasets = data && data.datasets;
			    if (!datasets || datasets.length === 0) return;

			    const raw = datasets[0].data || [];
			    const values = raw.map(v => Number(v) || 0);

			    const total = values.reduce((s, n) => s + n, 0);
			    const completed = values[0] || 0;
			    const percentage = total > 0 ? Math.round((completed / total) * 100) : 0;
			    const text = percentage + '%';

			    const centerX = (chartArea.left + chartArea.right) / 2;
			    const centerY = (chartArea.top + chartArea.bottom) / 2;

			    ctx.save();
			    const fontSize = Math.max(12, Math.floor(Math.min(chartArea.width, chartArea.height) / 6));
			    ctx.font = 'bold ' + fontSize + 'px Jua';
			    ctx.textAlign = 'center';
			    ctx.textBaseline = 'middle';
			    ctx.fillStyle = '#333';
			    ctx.fillText(text, centerX, centerY);
			    ctx.restore();
		}
	};
	
	const doughnutPieOptions = {
	    responsive: true,
	    animation: {
	            animateScale: true,
	            animateRotate: true
	    },
	    cutout: '70%'
	};

	if ($("#doughnutChart").length) {
		var doughnutChartCanvas = $("#doughnutChart").get(0).getContext("2d");
		var doughnutChart = new Chart(doughnutChartCanvas, {
		        type: 'doughnut',
		        data: doughnutPieData,
		        options: doughnutPieOptions,
		        plugins: [centerTextPlugin]
		});
	}
		
	const renderHealthTable = (healthList) => {
		  const incompleteTableBody = $('#healthTable table tbody');
		  const completedTableBody = $('#completedHealthTable table');
		  
		  incompleteTableBody.empty();
		  completedTableBody.empty();
		  healthList.forEach(health => {
		    if (health.healDone === false) {
		      const row = $('<tr></tr>');
		      const statusCheckbox = 
		        '<div class="form-check" style="margin-bottom: 0;">' +
		          '<input class="form-check-input complete-checkbox" type="checkbox" id="health-check-' + health.healId + '" data-health-id="' + health.healId + '">' +
		          '<label class="form-check-label" for="health-check-' + health.healId + '">완료</label>' +
		        '</div>';
		      row.append(
		        $('<td></td>').addClass('col-width-1').css({ height : '51.67px', padding: '5px 0' }).text(health.healName),
		        $('<td></td>').addClass('col-width-2').css({ height : '51.67px', padding: '5px 0' }).text(health.healAmount),
		        $('<td></td>').addClass('col-width-3').css({ height : '51.67px', padding: '5px 0' }).append(statusCheckbox)
		      );
		      incompleteTableBody.append(row);
		    } else if (health.healDone === true) {
		      const row = $('<tr></tr>');
		      row.append(
		        $('<td></td>').css({ height: '51.67px', padding: '5px 0' }).text(health.healName),
		        $('<td></td>').css({ height: '51.67px', padding: '5px 0' }).text(health.healAmount)
		      );
		      completedTableBody.append(row);
		    }
		  });
	};
	
    const updateBMIStatus = (bmi) => {
        const bmiDesc = $('#BMIDesc');
        const bmiEl = $('#BMI');
        bmiEl.html(bmi);
        bmiDesc.removeClass("underweight normal overweight obese");
        bmiEl.removeClass("underweight normal overweight obese");
        let status;
        if (bmi < 18.6) {
            status = "underweight";
            bmiDesc.html("저체중");
        } else if (bmi < 25) {
            status = "normal";
            bmiDesc.html("정상체중");
        } else if (bmi < 30) {
            status = "overweight";
            bmiDesc.html("과체중");
        } else {
            status = "obese";
            bmiDesc.html("비만");
        }
        bmiDesc.addClass(status);
        bmiEl.addClass(status);
    };

    updateBMIStatus(${pInfo.bMI});

    $("#healthNameContainer .dropdown-item").on("click", function() {
        const selectedText = $(this).text();     
        if (selectedText === '기타') {
            $("#healthNameBtn").hide().html("");
            $("#otherHealthName").show().val('').focus();
            $("#cancelOtherBtn").show();
        } else {
            $("#healthNameBtn").html(selectedText).show();
            $("#otherHealthName").hide();
            $("#cancelOtherBtn").hide();
        }
    });

    $("#cancelOtherBtn").on("click", function() {
        $("#healthNameBtn").html("추가할 운동을 선택해 주세요.").show();
        $("#otherHealthName").hide().val('');
        $("#cancelOtherBtn").hide();
    });
	
    $('#healthAddForm').on('submit', function(event) {
        event.preventDefault();
        const defaultText = "추가할 운동을 선택해 주세요.";
        const healthNameBtnText = $('#healthNameBtn').text().trim();
        const otherHealthNameInput = $('#otherHealthName');
        let healthName;
        if (healthNameBtnText === defaultText) {
            alert("추가할 운동을 선택하거나 입력해 주세요.");
            return;
        }
        if (otherHealthNameInput.is(':visible')) {
            healthName = otherHealthNameInput.val().trim();
            if (healthName === '') {
                alert("운동 이름을 직접 입력해 주세요.");
                return;
            }
        } else {
            healthName = healthNameBtnText;
        }

        const formData = {
            healthName: healthName,
            healthAmount: $('#healthAmount').val()
        };
        
        $.ajax({
            type: "POST",
            url: "/addHealth",
            data: formData,
            success: function(response) {
                if (response.success) {
                    renderHealthTable(response.healthList);
                    $('#healthAddForm')[0].reset();
                    $("#healthNameBtn").html("추가할 운동을 선택해 주세요.").show();
                    $("#otherHealthName").hide().val('');
                    $("#cancelOtherBtn").hide();
                    doughnutChart.data.datasets[0].data = response.chartData;
                    doughnutChart.data.labels = response.chartLabel;
                    
                    doughnutChart.update();
                    
                    $("#healthDonePer").html(response.healthDonePer);
                } else {
                    alert("운동 추가에 실패했습니다: " + response.message);
                }
            },
            error: function(xhr, status, error) {
                alert('서버 오류로 인해 운동 추가에 실패했습니다.');
            }
        });
    });
        
    $('#pInfoForm').on('submit', function(event) {
        event.preventDefault();
        const formData = {
            height: $('input[name="height"]').val(),
            weight: $('input[name="weight"]').val()
        };
        $.ajax({
            type: "POST",
            url: "/changePInfo",
            data: formData,
            success: function(result) {
                $('input[name="height"]').val(result.height);
                $('input[name="weight"]').val(result.weight);
                updateBMIStatus(result.bMI);
            },
            error: function(xhr, status, error) {
                alert('개인정보 변경에 실패했습니다. 다시 시도해 주세요.');
            }
        });
    });
    
    $('#healthTable').on('change', '.complete-checkbox', function() {
        const checkbox = $(this);
        const healthId = parseInt(checkbox.attr('data-health-id'));
        const isChecked = checkbox.is(':checked');

        if (isChecked) {
            if (confirm('운동을 완료 처리하시겠습니까?')) {
                if (typeof healthId !== 'number' || isNaN(healthId) || healthId === 0) {
                    alert("운동 ID가 유효하지 않아 요청을 보낼 수 없습니다. 다시 시도해 주세요.");
                    checkbox.prop('checked', false);
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "/changeHealthDone",
                    data: { healId: healthId },
                    success: function(response) {
                        if (response.success) {
                            alert('완료 처리되었습니다!');
                            renderHealthTable(response.healthList);
                            doughnutChart.data.datasets[0].data = response.chartData;
                            doughnutChart.data.labels = response.chartLabel;
                            
                            doughnutChart.update();
                            $("#healthDonePer").html(response.healthDonePer);
                        } else {
                            alert('완료 처리에 실패했습니다: ' + response.message);
                            checkbox.prop('checked', false);
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('서버 오류로 실패했습니다.');
                        checkbox.prop('checked', false);
                    }
                });
            } else {
                checkbox.prop('checked', false);
            }
        }
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
        	<div class="wrapper"  style="width:1330px; height:100%; margin:0 auto">
          <div class="row">
            <div class="col-md-8 grid-margin stretch-card" style="height:350px">
              <div class="card tale-bg"  style="background:white;">
                <div class="card-body">
                  <div class="table-responsive">
                  <table class="table table-hover" style="text-align: center;">
					  <thead style="height:30px">
					    <tr>
					      <th class="col-width-1"><h3>해야할 운동</h3></th>
					      <th class="col-width-2"><h3>목표량</h3></th>
					      <th class="col-width-3"><h3>완료체크</h3></th>
					    </tr>
					  </thead>
			 	  </table>
                  <div class="hide-scrollbar" id="healthTable" style="height: 200px; overflow-y: scroll;">
					    <table class="table table-hover" style="text-align: center;">
					        <tbody>
					            <c:forEach items="${healthList}" var="health">
					            	<c:if test="${health.healDone == false}">
						                <tr>
						                    <td class="col-width-1" style="height:40px; padding : 5px 0">${health.healName}</td>
						                    <td class="col-width-2" style="height:40px; padding : 5px 0">${health.healAmount}</td>
						                    <td class="col-width-3" style="height:40px; padding : 5px 0">
						                    
						                    	<div class="form-check">
											        <input class="form-check-input complete-checkbox" type="checkbox" id="health-check-${health.healId}" data-health-id="${health.healId}" ${health.healDone ? 'checked disabled' : ''}>
											      	<label class="form-check-label" for="health-check-${health.healId}">
											            체크
											        </label>  
											    </div>
                    						</td>
						                </tr>
					                </c:if>
					            </c:forEach>
					        </tbody>
					    </table>
					</div>
                    <form id="healthAddForm">
                    <div class="row" style="width:90%;background:white; margin:0 auto; margin-right: 50px;justify-content:space-around;">
                    	
                    	<div class="col-md-5 grid-margin stretch-card" >
                    		<div class="card tale-bg">
                    			<div id="healthNameContainer" style="width:100%; display: flex; align-items: center; justify-content: center; gap: 5px;">
								    <button type="button" id="healthNameBtn" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" style="width:100%; height:45px; background-color:#F5F7F9;color:black; border:none; text-align: center;">
								      추가할 운동을 선택해 주세요.
								    </button>
								    <div class="dropdown-menu" style="width:100%;">
								      <a class="dropdown-item" href="#">달리기</a>
								      <a class="dropdown-item" href="#">스쿼트</a>
								      <a class="dropdown-item" href="#">자전거 타기</a>
								      <a class="dropdown-item" href="#">팔굽혀펴기</a>
								      <a class="dropdown-item" href="#">윗몸일으키기</a>
								      <a class="dropdown-item" href="#">기타</a>
								    </div>
								
								    <input type="text" id="otherHealthName" class="form-control" placeholder="운동 이름 직접 입력" style="display:none; width:80%; height: 45px;">
								    
								    <button type="button" id="cancelOtherBtn" class="btn" style="display:none; padding: 0; width:20%"> 선택
								     </button>
								</div>
							</div>
                    	</div>
                    	
                    	<div class="col-md-3 grid-margin stretch-card">
                    		<div class="card tale-bg"  style="background:#F5F7F9;height:45px; align-items: center">
                    			<input id="healthAmount" type="number" placeholder="목표량을 입력해주세요." style="height:45px;background:#F5F7F9;border:none;border-radius:15px;text-align: center;font-size:15px" required>
                    		</div>
                    	</div>
                    	<div class="col-md-2 grid-margin stretch-card" style="margin-left: 60px">
                    		<input type="submit" style="height:100%;color:white;background-color: #7A5EE7;border: none; border-radius: 15px" value="운동 추가">
                    	</div>
                    	
                    </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-4 grid-margin transparent" style="height:350px;">
              <div class="card tale-bg"  style="background:white;height:350px;">
                <div class="card-header" style="padding:20px;padding-bottom:0;background:none">
                		<h3>완료한 운동 목록</h3>
               	</div>
                <div class="hide-scrollbar" style="height: 250px; overflow-y: scroll;">
                	<div class="card-body" id="completedHealthTable">
	                	<table class="table table-hover" style="text-align: center;">
		                	<c:forEach items="${healthList}" var="health">
								<c:if test="${health.healDone == true}">				
									<tr>
								    	<td style="height:40px">${health.healName}</td>
								        <td style="height:40px">${health.healAmount}</td>
								    </tr>
							    </c:if>
							</c:forEach>
						</table>
					</div>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-4 grid-margin stretch-card" style="height:350px;" >
              <div class="card tale-bg"  style="background:white;">
              
              	<form id="pInfoForm" method="post">
	              	<div class="row">
	              	<c:choose>
	              		<c:when test="${pInfo != null}">
			                <div class="col-md-6 transparent">
			                	<div class="card-body" style="padding-bottom:0;background:none">
			                		<h3>키</h3>
			                	</div>
			                	<div class="card-body" style="padding-top:0;">
			                		
			                		<input type="number" step="0.1" value="${pInfo.height}" name="height" style="width:100%; border:none;height:45px; background:#F5F7F9;text-align: center;border-radius:15px">
			                		
			                	</div>
			                </div>
			                <div class="col-md-6 transparent">
			                	<div class="card-body" style="padding-bottom:0;background:none">
			                		<h3>몸무게</h3>
			                	</div>
			                	<div class="card-body" style="padding-top:0;">
			                		<input type="number" step="0.1" value="${pInfo.weight}" name="weight" style="width:100%;border:none;height:45px;background:#F5F7F9; text-align: center; border-radius:15px">
			                	</div>
			                </div>
		                </c:when>
		                <c:otherwise>
		                	<div class="col-md-6 transparent">
		                	<div class="card-body" style="padding-bottom:0;background:none">
		                		<h3>키</h3>
		                	</div>
		                	<div class="card-body" style="padding-top:0;">
		                		
		                		<input id="height" type="number" value="" name="height" style="width:100%; border:none;height:45px; background:#F5F7F9;text-align: center;border-radius:15px">
		                		
		                	</div>
		                </div>
		                <div class="col-md-6 transparent">
		                	<div class="card-body" style="padding-bottom:0;background:none">
		                		<h3>몸무게</h3>
		                	</div>
		                	<div class="card-body" style="padding-top:0;">
		                		<input id="weight" type="number" value="" name="weight" style="width:100%;border:none;height:45px;background:#F5F7F9; text-align: center; border-radius:15px">
		                	</div>
		                </div>
		                </c:otherwise>
		            </c:choose>
	              	</div>
		            <div class="card-header" style="padding-top:0;padding-bottom:5px;background:white">
		              	<div class="row">
			              	<div class="col-md-9 transparent">
			              	</div>
			              	<div class="col-md-2 transparent">
			              		<input type="submit" style="margin-left:10px;width:60px; height:30px;color:white;background-color: #7A5EE7;border: none; border-radius: 10px" value="수정">
		              		</div>
	              		</div>
              		</div>
              	</form>
              	<div class="card-body" style="padding:20px;padding-bottom:0;padding-top:10;background:none">
              		<h3>BMI</h3>
	              	<div class="row">
	              		<div class="col-md-6 transparent" style="display:flex; justify-content: center; align-items: center; height: 120px">
	              			<h3 id="BMI">${pInfo.bMI}</h3>
	              		</div>
	              		<div class="col-md-6 transparent" style="display:flex; justify-content: center; align-items: center; height: 120px">
	              			<h3 id="BMIDesc"></h3>
	              		</div>
	              	</div>
              	</div>
              </div>
            </div>
            <div class="col-md-4 grid-margin stretch-card" style="height:350px;">
              <div class="card tale-bg"  style="background:white;">
                <div class="card-body">
                	<h3>꾸준 랭킹</h3>
                	<table class="table table-hover" style="text-align: center;">
                      <thead  style="height:30px">
                        <tr>
                          <th>순위</th>
                          <th>이름</th>
                          <th>완료율</th>
                        </tr>
                      </thead>
                      <tbody style="height:200px">
                        
                      </tbody>
                    </table>
                </div>
                
              </div>
            </div>
            <div class="col-md-4 grid-margin stretch-card" style="height:350px;">
              <div class="card tale-bg"  style="background:white;">
              	<div class="card-body">
              		<h3>완료율</h3>
              		<div class="card-body" style="width:400px; height:400px;">
                  <canvas id="doughnutChart"></canvas>      		
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
</body>

</html>