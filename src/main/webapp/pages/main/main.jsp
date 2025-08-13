<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,shrink-to-fit=no">
  <title>Dashboard</title>

  <!-- Skydash / Bootstrap vendor css -->
  <link rel="stylesheet" href="<c:url value='/vendors/feather/feather.css'/>">
  <link rel="stylesheet" href="<c:url value='/vendors/ti-icons/css/themify-icons.css'/>">
  <link rel="stylesheet" href="<c:url value='/vendors/css/vendor.bundle.base.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/vertical-layout-light/style.css'/>">
  <link rel="shortcut icon" href="<c:url value='/images/favicon.png'/>" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Jua&display=swap">

  <style>
    body{ font-family:'Jua',sans-serif; }

    /* 대시보드 폭 제한 */
    .dashboard-wrap{ max-width: 980px; margin:0 auto; }

    /* Bootstrap4는 gap 유틸 없음 → 커스텀 패딩 */
    .row.dash-gutter{ margin-left:-8px; margin-right:-8px; }
    .row.dash-gutter > [class^="col-"], .row.dash-gutter > [class*=" col-"]{ padding-left:8px; padding-right:8px; }

    /* 카드 공통 */
    .dash-card{
      background:#fff; border-radius:12px;
      box-shadow:0 4px 12px rgba(0,0,0,.06);
      display:flex; flex-direction:column; overflow:hidden;
      aspect-ratio: 1 / 1;                   /* 정사각형 */
    }
    /* 아주 구형 브라우저 fallback */
    @supports not (aspect-ratio: 1 / 1){
      .dash-card{ position:relative; }
      .dash-card::before{ content:""; display:block; padding-top:100%; }
      .dash-card > *{ position:absolute; inset:0; display:flex; flex-direction:column; }
    }

    .dash-card__header{ display:flex; align-items:center; justify-content:space-between; padding:12px 14px; border-bottom:1px solid #eee; }
    .dash-card__title{ margin:0; font-weight:700; font-size:1.05rem; }
    .dash-card__body{ flex:1; padding:12px 14px; overflow:auto; }
    .dash-card__empty{ color:#9aa0a6; font-size:.95rem; }
    .dash-btn{ border:none; background:#f5f6f8; width:28px; height:28px; border-radius:8px; line-height:28px; text-align:center; cursor:pointer; }

    /* 목표 확인 스타일 */
    .character-circle {
        width: 150px;
        height: 150px;
        border: 3px solid #e0e0e0;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        background: #fff;
        margin: 0 auto 20px;
        position: relative;
    }

    .sprout-character {
        width: 100px;  /* 이미지 크기 조절 */
        height: 100px;
        object-fit: contain;  /* 비율 유지하며 크기 조절 */
        animation: float 3s ease-in-out infinite;
    }

    .level-badge {
        text-align: center;
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
  </style>
</head>

<body>
<div class="container-scroller">
  <jsp:include page="/components/header.jsp"/>
  <div class="container-fluid page-body-wrapper">
    <jsp:include page="/components/navbar.jsp"/>

    <div class="main-panel">
      <div class="content-wrapper">
        <div class="dashboard-wrap">
          <div class="row dash-gutter">
            <!-- 1 -->
            <div class="col-12 col-md-4 mb-3">
              <section class="dash-card">
                <div class="dash-card__header">
                  <h5 class="dash-card__title">오늘 할 일</h5><a class="dash-btn" href="<c:url value='/todo'/>" aria-label="오늘 할 일 페이지로 이동">+</a>
                </div>
                <div class="dash-card__body" id="card-body-1"><div class="dash-card__empty">데이터를 불러오는 중…</div></div>
              </section>
            </div>
            <!-- 2 -->
            <div class="col-12 col-md-4 mb-3">
              <section class="dash-card">
                <div class="dash-card__header">
                  <h5 class="dash-card__title">할 일</h5>  <a class="dash-btn" href="<c:url value='/todo'/>" aria-label="할 일 페이지로 이동">+</a>

                </div>
                <div class="dash-card__body" id="card-body-2"><div class="dash-card__empty">데이터를 불러오는 중…</div></div>
              </section>
            </div>
            <!-- 3 -->
            <div class="col-12 col-md-4 mb-3">
              <section class="dash-card">
                <div class="dash-card__header">
                  <h5 class="dash-card__title">이번달 가계부 요약</h5>  <a class="dash-btn" href="<c:url value='/account'/>" aria-label="가계부 페이지로 이동">+</a>

                </div>
                <div class="dash-card__body" id="card-body-3"><div class="dash-card__empty">데이터를 불러오는 중…</div></div>
              </section>
            </div>
            <!-- 4 -->
            <div class="col-12 col-md-4 mb-3">
              <section class="dash-card">
                <div class="dash-card__header">
                  <h5 class="dash-card__title">오늘 할 운동</h5>  <a class="dash-btn" href="<c:url value='/moveHealth'/>" aria-label="운동 페이지로 이동">+</a>

                </div>
                <div class="dash-card__body" id="card-body-4"><div class="dash-card__empty">데이터를 불러오는 중…</div></div>
              </section>
            </div>
            <!-- 5 -->
            <div class="col-12 col-md-4 mb-3">
              <section class="dash-card">
                <div class="dash-card__header">
                  <h5 class="dash-card__title">결과 요약</h5>
                  <a class="dash-btn" href="<c:url value='/goal'/>" aria-label="결과 요약 페이지로 이동">+</a>
                </div>
                <div class="dash-card__body" id="card-body-5">
                    <div class="dash-card-goal">
                        <div>
                            <div class="character-circle">
                                <div>
                                    <img id="character-img" class="sprout-character" src="../../image/goal/tree01.png" alt="tree-img"/>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div id="level" class="level-badge">LV 5</div>
                            <div class="exp-container">
                                <div class="progress">
                                    <div id="progress" class="progress-bar" role="progressbar" style="width: 20%;" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
              </section>
            </div>
            <!-- 6 -->
            <div class="col-12 col-md-4 mb-3">
              <section class="dash-card">
                <div class="dash-card__header">
                  <h5 class="dash-card__title">메모</h5>  <a class="dash-btn" href="<c:url value='/note'/>" aria-label="메모 페이지로 이동">+</a>

                </div>
                <div class="dash-card__body" id="card-body-6"><div class="dash-card__empty">데이터를 불러오는 중…</div></div>
              </section>
            </div>
            
          </div>
        </div>
      </div>

      <footer class="footer">
        <div class="d-sm-flex justify-content-center justify-content-sm-between">
          <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">
            Copyright © 2021. Premium
            <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap admin template</a>
            from BootstrapDash.
          </span>
          <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">
            Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i>
          </span>
        </div>
      </footer>
    </div>
  </div>
</div>

<!-- JS -->
<script src="<c:url value='/vendors/js/vendor.bundle.base.js'/>"></script>
<script src="<c:url value='/vendors/chart.js/Chart.min.js'/>"></script>
<script src="<c:url value='/vendors/datatables.net/jquery.dataTables.js'/>"></script>
<script src="<c:url value='/vendors/datatables.net-bs4/dataTables.bootstrap4.js'/>"></script>
<script src="<c:url value='/js/off-canvas.js'/>"></script>
<script src="<c:url value='/js/hoverable-collapse.js'/>"></script>
<script src="<c:url value='/js/template.js'/>"></script>
<script src="<c:url value='/js/settings.js'/>"></script>

<script>
  const memId = <c:out value="${sessionScope.member.memId}" default="1"/>;

  const el = sel => document.querySelector(sel);
  function renderList(targetSel, items, textFn){
    const root = el(targetSel);
    if(!Array.isArray(items) || !items.length){
      root.innerHTML = '<div class="dash-card__empty">데이터가 없습니다.</div>'; return;
    }
    const ul = document.createElement('ul');
    ul.className = 'list-unstyled mb-0';
    items.forEach(i=>{
      const li = document.createElement('li');
      li.className = 'mb-2';
      li.textContent = textFn ? textFn(i) : String(i);
      ul.appendChild(li);
    });
    root.replaceChildren(ul);
  }

  // 오늘 할 일: 전체 목록에서 최근 3개만
  $.getJSON('<c:url value="/todo/list"/>')
    .done(list => {
      const toTs = (t) => {
        // 날짜/시간 → 타임스탬프 (없으면 0)
        const d = t?.todoDate ? new Date(typeof t.todoDate === 'string' ? t.todoDate : t.todoDate) : null;
        const hhmm = (t?.todoTime || '00:00').slice(0,5);
        if (!d || isNaN(d)) return 0;
        const [h,m] = hhmm.split(':').map(n=>+n||0);
        return new Date(d.getFullYear(), d.getMonth(), d.getDate(), h, m).getTime();
      };

      const top3 = (Array.isArray(list) ? list.slice() : [])
        .sort((a,b) => (toTs(b) - toTs(a)) || ((b.todoId||0) - (a.todoId||0))) // 최근순
        .slice(0,3);

      renderList('#card-body-1', top3, t => t.todoContent);
    });

  // 중요 할 일: 랜덤 순서로 렌더
  $.getJSON('<c:url value="/todo/list"/>')
    .done(list => {
      const arr = Array.isArray(list) ? list.slice() : [];

      // Fisher–Yates shuffle
      for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [arr[i], arr[j]] = [arr[j], arr[i]];
      }

      renderList('#card-body-2', arr, t => t.todoContent);
    })
    .fail(() => renderList('#card-body-2', [], null));

  // 메모
  $.getJSON('<c:url value="/note/list"/>', { memId })
    .done(list => renderList('#card-body-6', list, n => n.noteName));
  
  $(function(){
	  const memId = <c:out value="${sessionScope.member.memId}" default="1"/>;

	  const $box = $('#card-body-3');

	  // UI 뼈대
	  $box.html(`
	    <ul class="list-unstyled mb-0">
	      <li class="d-flex justify-content-between align-items-center mb-3">
	        <span class="font-weight-bold">이번 달 총 수입</span>
	        <span id="sumIncome" class="font-weight-bold text-success">₩ 0</span>
	      </li>
	      <li class="d-flex justify-content-between align-items-center mb-3">
	        <span class="font-weight-bold">이번 달 지출 목표</span>
	        <span id="sumTarget" class="font-weight-bold text-purple">₩ 0</span>
	      </li>
	      <li class="d-flex justify-content-between align-items-center">
	        <span class="font-weight-bold">이번 달 총 지출</span>
	        <span id="sumExpense" class="font-weight-bold text-danger">₩ 0</span>
	      </li>
	    </ul>
	  `);

	  updateAccountSummary();

	  // ─────────────────────────────────────────────
	  function updateAccountSummary(){
	    const yymm = new Date().toISOString().slice(0,7);   // "YYYY-MM"
	    const monthStart = yymm + '-01';

	    // ① 이번 달 가계부 목록
	    const pAcc = $.getJSON('<c:url value="/getMonthAcc"/>', { date: monthStart });

	    // ② 지출 목표 (서버에 없으면 localStorage fallback)
	    const pTarget = loadMonthlyTarget(yymm, memId);

	    $.when(pAcc, pTarget).done((accRes, targetVal) => {
	      // jQuery.when 특성: accRes[0] = 실제 데이터
	      const list = Array.isArray(accRes[0]) ? accRes[0]
	                 : (accRes[0]?.data || accRes[0]?.result || []);

	      const income = list.reduce((s, r) => s + (isIncome(r) ? toNum(r.accAmount) : 0), 0);
	      const expense= list.reduce((s, r) => s + (!isIncome(r) ? toNum(r.accAmount) : 0), 0);

	      $('#sumIncome').text(krw(income));
	      $('#sumTarget').text(krw(targetVal));
	      $('#sumExpense').text(krw(expense));
	    }).fail(() => {
	      $box.html('<div class="dash-card__empty">가계부 요약을 불러오지 못했습니다.</div>');
	    });
	  }

	  // ── 지출 목표 로딩 (서버→로컬스토리지 순)
	  function loadMonthlyTarget(yyyymm, memId){
	    const d = $.Deferred();

	    // 서버 엔드포인트가 있으면 사용 (예: /account/target?month=YYYY-MM)
	    $.getJSON('<c:url value="/account/target"/>', { month: yyyymm })
	      .done(res => {
	        const n = toNum(res?.amount ?? res?.target ?? res);
	        if (!isNaN(n)) d.resolve(n); else d.resolve(getLocalTarget(yyyymm, memId));
	      })
	      .fail(() => d.resolve(getLocalTarget(yyyymm, memId)));

	    return d.promise();
	  }

	  // spending 페이지에서 저장해 둔 값(localStorage) 읽기
	  function getLocalTarget(yyyymm, memId){
	    const key = `accTarget:${memId}:${yyyymm}`;
	    return toNum(localStorage.getItem(key) || 0);
	  }

	  // ── 유틸
	  function isIncome(r){
	    const v = r?.accIncome;
	    if (typeof v === 'boolean') return v;
	    if (typeof v === 'number')  return v === 1;
	    if (typeof v === 'string')  return v === '1' || v.toLowerCase() === 'true' || v === '수입';
	    return false;
	  }
	  function toNum(v){ const n = Number(String(v ?? '').replace(/[^0-9.-]/g,'')); return isNaN(n) ? 0 : n; }
	  function krw(n){ return '₩ ' + Number(n||0).toLocaleString('ko-KR'); }
	});
  
  // 목표 요약 관련 스크립트
  // 내 Goal를 가져워서 출력
  const level = document.querySelector('#level');
  const characterImg = document.querySelector('#character-img');
  const progress = document.querySelector("#progress");

  // 함수 호출
  // checkTargetAndCalculateScore();

  fetch('/get-all-target')
      .then(res => res.json())
      .then((data) => {
          if (data.check !== 1) {

          }
      })
      .catch(error => console.error('Error:', error));

  fetch('/get/member')
      .then(res => res.json())
      .then((data) => {
          // console.log(data);
          //level.textContent = "Lv " + data.goal.goalLv;
          level.textContent = "Lv " + data.goal.goalExp / 50;
          if (data.goal.goalLv <= 3) {
              characterImg.src = "/image/goal/tree0" + (data.goal.goalExp / 50 + 1) + ".png";
          } else {
              let level = data.goal.goalExp / 50 - 4
              characterImg.src = "/image/goal/tree0" + ((level % 6) + 4)  + ".png";
          }
          progress.style.width = ((data.goal.goalExp % 50) / 50) + '%';
      })
      .catch(error => console.error('Error:', error));
</script>
</body>
</html>
