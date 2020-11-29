import PropTypes from 'prop-types';
import React, { useState } from 'react';

import Chart from './chart';

const App = ({ bitCoins }) => {
  const [timeUnit, setTimeUnit] = useState('minute');
  const [bitCoinData, setBitCoinData] = useState(bitCoins);

  return (
    <div>
      <h3 style={{ textAlign: 'center' }}>
        Chart Showing bitcoin prices for varying time periods
      </h3>

      <Chart
        timeUnit={timeUnit}
        bitCoinData={bitCoinData}
        setBitCoinData={setBitCoinData}
      />

      <div style={{ marginTop: '20px' }}>
        <p>Choose periods: </p>

        <button onClick={() => setTimeUnit('minute')}>1 hour</button>
        <button onClick={() => setTimeUnit('hour')}>1 day</button>
        <button onClick={() => setTimeUnit('day')}>1 week</button>
        <button onClick={() => setTimeUnit('week')}>1 month</button>
        <button onClick={() => setTimeUnit('month')}>1 year</button>
      </div>

      <p>
        Note: The first 1 hour display might be empty if viewed on heroku because the free dyno on
        heroku idles out after a few minutes of inactivity and therefore the worker stops.
        Kindly Stay on the page for a few minutes and see the graph start populating
      </p>
    </div>
  )
};

App.propTypes = {
  bitCoins: PropTypes.instanceOf(Object).isRequired,
};

export default App;
