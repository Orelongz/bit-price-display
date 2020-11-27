import Chart from 'chart.js';
import PropTypes from 'prop-types';
import React, { useEffect, useRef } from 'react';

const LineChart = ({ data, width, height }) => {
  const myChart = useRef();
  const chartRef = useRef();
  const didMountRef = useRef(false);

  useEffect(() => {
    if (didMountRef.current) {
      myChart.current.data.labels = data.map(d => d.time);
      myChart.current.data.datasets[0].data = data.map(d => d.value);
      myChart.current.update();
    } else {
      drawChart();
      didMountRef.current = true;
    }
  }, [data]);
  
  const drawChart = () => {
    myChart.current = new Chart(chartRef.current, {
      type: 'line',
      options: {
        scales: {
          xAxes: [
            {
              type: 'time',
              time: {
                unit: 'week'
              }
            }
          ],
          yAxes: [
            {
              ticks: {
                min: 0
              }
            }
          ]
        }
      },
      data: {
        labels: data.map(d => d.time),
        datasets: [{
          label: 'graph title',
          data: data.map(d => d.value),
          fill: 'none',
          pointRadius: 2,
          borderWidth: 1,
          lineTension: 0
        }]
      }
    });
  };

  return <canvas ref={chartRef} />;
};

LineChart.defaultProps = {
  width: 800,
  height: 400
};

LineChart.propTypes = {
  width: PropTypes.number.isRequired,
  height: PropTypes.number.isRequired,
  data: PropTypes.instanceOf(Array).isRequired, 
};

export default LineChart;
