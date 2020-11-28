import dayjs from "dayjs";
import Chart from 'chart.js';
import PropTypes from 'prop-types';
import React, { useEffect, useRef } from 'react';

import consumer from "../channels/consumer";

const LineChart = ({ timeUnit, bitCoinData, setBitCoinData }) => {
  const myChart = useRef();
  const chartRef = useRef();
  const data = bitCoinData[timeUnit];

  useEffect(() => {
    if (myChart.current) {
      updateChart();
    } else {
      drawChart();

      consumer.subscriptions.create("BitCoinChannel", {
        // Called when the subscription is ready for use on the server
        connected() {},

        // Called when the subscription has been terminated by the server
        disconnected() {},

        // Called when there's incoming data on the websocket for this channel
        received(incoming) {
          if (incoming.type === 'minute') {
            setBitCoinData({ ...bitCoinData, minute: incoming.data });
          }
        }
      });
      
    }

    () => myChart.current.destroy();
  }, [drawChart, updateChart, timeUnit, bitCoinData]);

  const updateChart = () => {
    myChart.current.config.data.labels = chartLabel();
    myChart.current.config.data.datasets[0].data = chartData();
    myChart.current.update();
  }

  const chartData = () => data.map((obj) => ({ x: new Date(obj.timestamp).getTime(), y: obj.price}));

  const chartLabel = () => data.map(d => dayjs(d.label_time).format("DD, MMM YYYY | HH:mm"));

  const chartConfig = {
    type: 'line',
    data: {
      labels: chartLabel(),
      datasets: [{
        tension: 0,
        fill: false,
        type: 'line',
        borderWidth: 2,
        pointRadius: 0,
        data: chartData(),
        label: 'Bitcoin price',
        borderColor: '#fe8b36',
        backgroundColor: '#fe8b36'
      }]
    },
    options: {
      animation: {
        duration: 0
      },
      responsive: true,
      scales: {
        xAxes: [{
          scaleLabel: {
            display: true,
            labelString: "Time Line",
          }
        }],
        yAxes: [{
          scaleLabel: {
            display: true,
            labelString: "Bitcoin price ($)",
          }
        }]
      }
    }
  };

  const drawChart = () => {
    myChart.current = new Chart(chartRef.current, chartConfig);
  };

  return (
    <div>
      <canvas ref={chartRef} width="1000" height="300" />
    </div>
  );
};

LineChart.propTypes = {
  timeUnit: PropTypes.string.isRequired,
  setBitCoinData: PropTypes.func.isRequired,
  bitCoinData: PropTypes.instanceOf(Object).isRequired
};

export default LineChart;
