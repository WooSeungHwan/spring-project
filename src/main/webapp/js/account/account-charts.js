// DOM이 완전히 로드된 후 실행
document.addEventListener('DOMContentLoaded', function() {
    initializeChart();
});

let expenseChart = null;
let currentYear = 2021;

const chartData = {
    2021: [800, 1800, 2200, 12500, 3000, 2800, 2500, 2300, 1900, 1600, 2400, 3200],
    2022: [1200, 2000, 2500, 3000, 3500, 3200, 2800, 2600, 2200, 1900, 2700, 3500],
    2023: [1500, 2200, 2800, 3200, 3800, 3500, 3100, 2900, 2500, 2100, 3000, 3800]
};

function initializeChart() {
    try {
        const canvas = document.getElementById('expenseChart');
        if (!canvas) {
            console.error('Canvas element not found');
            return;
        }

        const ctx = canvas.getContext('2d');
        if (!ctx) {
            console.error('Cannot get 2D context');
            return;
        }

        // 차트 색상 배열 생성 (4월만 다른 색)
        const backgroundColors = [];
        for (let i = 0; i < 12; i++) {
            backgroundColors.push(i === 3 ? '#1f2937' : '#8b5cf6');
        }

        expenseChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    data: chartData[currentYear],
                    backgroundColor: backgroundColors,
                    borderRadius: 4,
                    barThickness: 20,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: {
                    padding: 0
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#1f2937',
                        titleColor: '#ffffff',
                        bodyColor: '#ffffff',
                        padding: 10,
                        displayColors: false,
                        callbacks: {
                            title: function(context) {
                                return context[0].label;
                            },
                            label: function(context) {
                                return 'Expense: $' + context.parsed.y.toLocaleString();
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                if (value === 0) return '$0';
                                if (value >= 1000) return '$' + (value/1000) + 'k';
                                return '$' + value;
                            },
                            color: '#9ca3af',
                            font: {
                                size: 11
                            }
                        },
                        grid: {
                            color: '#f3f4f6',
                            drawBorder: false
                        }
                    },
                    x: {
                        ticks: {
                            color: '#9ca3af',
                            font: {
                                size: 11
                            }
                        },
                        grid: {
                            display: false,
                            drawBorder: false
                        }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                },
                onHover: (event, activeElements) => {
                    canvas.style.cursor = activeElements.length > 0 ? 'pointer' : 'default';
                }
            }
        });

        console.log('Chart initialized successfully');

    } catch (error) {
        console.error('Error initializing chart:', error);
    }
}

function changeYear(direction) {
    try {
        currentYear += direction;
        if (currentYear < 2021) currentYear = 2023;
        if (currentYear > 2023) currentYear = 2021;

        const yearDisplay = document.getElementById('yearDisplay');
        if (yearDisplay) {
            yearDisplay.textContent = currentYear;
        }

        if (expenseChart && expenseChart.data) {
            expenseChart.data.datasets[0].data = chartData[currentYear];
            expenseChart.update();
        }
    } catch (error) {
        console.error('Error changing year:', error);
    }
}