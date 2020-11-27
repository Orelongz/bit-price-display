import React from 'react';
import ReactDOM from 'react-dom';

import Chart from './chart';

const App = props => {
  console.log(props)
  const data = [
    { time: '2007-04-23', value: '43.24' },
    { time: '2007-04-24', value: '95.35' },
    { time: '2007-04-25', value: '98.84' },
    { time: '2007-04-26', value: '59.92' },
    { time: '2007-04-29', value: '99.8' },
    { time: '2007-05-01', value: '99.47' },
    { time: '2007-05-02', value: '160.39' },
    { time: '2007-05-03', value: '100.4' }
  ];

  return (
    <div>
      <div>boom</div>
      <Chart data={data} />
    </div>
  )
};

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.createElement('div')),
  )
});
