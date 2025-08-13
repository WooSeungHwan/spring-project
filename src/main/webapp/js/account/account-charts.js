// 전역 변수
let currentYear = new Date().getFullYear();
let currentMonth = new Date().getMonth() + 1;
let expenseChart = null;
let monthlyData = [];

// 페이지 로드 시 실행
$(document).ready(function() {
    // 현재 연도 표시
    $('#yearDisplay').text(currentYear);

    // 데이터 로드 및 차트 초기화
    loadMonthData();
});

// 월별 데이터 로드
async function loadMonthData() {
    try {
        // 현재 달의 데이터 가져오기
        const currentDate = `${currentYear}-${String(currentMonth).padStart(2, '0')}-01`;
        const response = await fetch(`/getMonthAcc?date=${currentDate}`);

        if (!response.ok) {
            throw new Error('데이터를 가져오는데 실패했습니다.');
        }

        const data = await response.json();
        monthlyData = Array.isArray(data) ? data : (data.data || data.result || []);

        // 대시보드 카드 업데이트
        updateDashboardCards(monthlyData);

        // 연간 데이터 가져와서 차트 업데이트
        await loadYearlyDataAndUpdateChart();

    } catch (error) {
        console.error('데이터 로드 중 오류:', error);
    }
}

// 연간 데이터 로드 및 차트 업데이트
async function loadYearlyDataAndUpdateChart() {
    try {
        const monthlyTotals = {
            income: new Array(12).fill(0),
            expense: new Array(12).fill(0)
        };

        // 각 월별로 데이터 가져오기 (실제로는 한번에 연간 데이터를 가져오는 API가 있다면 그것을 사용)
        for (let month = 1; month <= 12; month++) {
            const date = `${currentYear}-${String(month).padStart(2, '0')}-01`;
            const response = await fetch(`/getMonthAcc?date=${date}`);

            if (response.ok) {
                const data = await response.json();
                const monthData = Array.isArray(data) ? data : (data.data || data.result || []);

                monthData.forEach(item => {
                    const amount = parseFloat(item.accAmount) || 0;
                    if (item.accIncome) {
                        monthlyTotals.income[month - 1] += amount;
                    } else {
                        monthlyTotals.expense[month - 1] += amount;
                    }
                });
            }
        }

        // 차트 업데이트
        updateExpenseChart(monthlyTotals);

    } catch (error) {
        console.error('연간 데이터 로드 중 오류:', error);
        // 오류 발생시 현재 월 데이터만으로 차트 생성
        const monthlyTotals = calculateMonthlyTotals(monthlyData);
        updateExpenseChart(monthlyTotals);
    }
}

// 대시보드 카드 업데이트
function updateDashboardCards(data) {
    const today = new Date().toISOString().split('T')[0];
    let todayExpense = 0;
    let monthlyIncome = 0;
    let monthlyExpense = 0;
    let currentTotalExpense = 0;

    // 데이터 집계
    data.forEach(item => {
        const amount = parseFloat(item.accAmount) || 0;
        const itemDate = item.accDate;

        if (item.accIncome) {
            monthlyIncome += amount;
        } else {
            monthlyExpense += amount;
            currentTotalExpense += amount;

            // 오늘 지출 계산
            if (itemDate === today) {
                todayExpense += amount;
            }
        }
    });

    // 지출 목표 (하드코딩된 값 사용 또는 API에서 가져오기)
    const monthlyGoal = 300000;
    const dailyGoal = monthlyGoal / 30;

    // DOM 업데이트
    updateCardValues({
        monthlyGoal: monthlyGoal,
        dailyGoal: Math.round(dailyGoal),
        todayExpense: todayExpense,
        currentExpense: currentTotalExpense,
        monthlyIncome: monthlyIncome,
        monthlyExpense: monthlyExpense
    });
}

// 카드 값 업데이트
function updateCardValues(values) {
    // 지출 목표
    $('.expense-item').eq(0).find('.expense-amount').text(`₩ ${values.monthlyGoal.toLocaleString()}`);

    // 하루 목표
    $('.expense-item').eq(1).find('.expense-amount').text(`₩ ${values.dailyGoal.toLocaleString()}`);

    // 오늘 지출
    $('.expense-item').eq(2).find('.expense-amount').text(`₩ ${values.todayExpense.toLocaleString()}`);

    // 현재 지출
    $('.expense-item').eq(3).find('.expense-amount').text(`₩ ${values.currentExpense.toLocaleString()}`);

    // 이번 달 수입
    $('.summary-card').eq(0).find('.summary-amount').text(`₩ ${values.monthlyIncome.toLocaleString()}`);

    // 이번 달 지출
    $('.summary-card').eq(1).find('.summary-amount').text(`₩ ${values.monthlyExpense.toLocaleString()}`);

    // 색상 업데이트 (목표 초과 시 빨간색)
    if (values.todayExpense > values.dailyGoal) {
        $('.expense-item').eq(2).find('.expense-amount').addClass('amount-red');
    }

    if (values.currentExpense > values.monthlyGoal) {
        $('.expense-item').eq(3).find('.expense-amount').addClass('amount-red');
    }
}

// 월별 데이터 집계
function calculateMonthlyTotals(data) {
    const monthlyTotals = {
        income: new Array(12).fill(0),
        expense: new Array(12).fill(0)
    };

    data.forEach(item => {
        const date = new Date(item.accDate);
        const month = date.getMonth();
        const amount = parseFloat(item.accAmount) || 0;

        if (item.accIncome) {
            monthlyTotals.income[month] += amount;
        } else {
            monthlyTotals.expense[month] += amount;
        }
    });

    return monthlyTotals;
}

// Chart.js 차트 업데이트
function updateExpenseChart(monthlyTotals) {
    const ctx = document.getElementById('expenseChart').getContext('2d');

    // 기존 차트가 있으면 제거
    if (expenseChart) {
        expenseChart.destroy();
    }

    // 새 차트 생성
    expenseChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            datasets: [
                {
                    label: '수입',
                    data: monthlyTotals.income,
                    backgroundColor: 'rgba(16, 185, 129, 0.8)',
                    borderColor: 'rgba(16, 185, 129, 1)',
                    borderWidth: 1,
                    borderRadius: 4,
                    barThickness: 20
                },
                {
                    label: '지출',
                    data: monthlyTotals.expense,
                    backgroundColor: 'rgba(239, 68, 68, 0.8)',
                    borderColor: 'rgba(239, 68, 68, 1)',
                    borderWidth: 1,
                    borderRadius: 4,
                    barThickness: 20
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'bottom',
                    labels: {
                        padding: 15,
                        font: {
                            size: 12
                        },
                        usePointStyle: true
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            label += '₩' + context.parsed.y.toLocaleString();
                            return label;
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        font: {
                            size: 11
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: {
                        color: 'rgba(0, 0, 0, 0.05)'
                    },
                    ticks: {
                        font: {
                            size: 11
                        },
                        callback: function(value) {
                            if (value >= 1000000) {
                                return '₩' + (value / 1000000) + 'M';
                            } else if (value >= 1000) {
                                return '₩' + (value / 1000) + 'K';
                            }
                            return '₩' + value;
                        }
                    }
                }
            }
        }
    });
}

// 연도 변경 함수
function changeYear(direction) {
    currentYear += direction;
    $('#yearDisplay').text(currentYear);
    loadMonthData();
}

// 가계부 추가 버튼 이벤트
$('#addAccListBtn').on('click', function() {
    const formData = {
        accDate: $('input[name="acc_date"]').val(),
        accIncome: $('select[name="acc_income"]').val() === '1',
        accCategory: $('input[name="acc_category"]').val(),
        accDesc: $('input[name="acc_desc"]').val(),
        accAmount: $('input[name="acc_amount"]').val(),
        accPayment: $('input[name="acc_payment"]').val(),
        accEtc: $('input[name="acc_etc"]').val()
    };

    // 유효성 검사
    if (!formData.accDate || !formData.accAmount) {
        alert('날짜와 금액은 필수 입력 항목입니다.');
        return;
    }
});