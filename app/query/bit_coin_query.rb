class BitCoinQuery
  CATEGORY_HASH = {
    'minute': {interval: '1min', period: 'min', duration: '60 minutes'},
    'hour': {interval: '30min', period: 'hour', duration: '24 hours'},
    'day': {interval: '2h', period: 'day', duration: '7 days'},
    'week': {interval: '6h', period: 'day', duration: '30 days'},
    'month': {interval: '5day', period: 'day', duration: '365 days'}
  }

  # https://stackoverflow.com/questions/15576794/best-way-to-count-records-by-arbitrary-time-intervals-in-railspostgres
  QUERY_STRING = (
    "SELECT Max(btc.id) AS id,
            Max(btc.price) AS price,
            Max(btc.timestamp) AS timestamp,
            to_char(start_time, 'YYYY-MM-DD HH24:MI:SS') as label_time
    FROM generate_series(
      date_trunc(?, localtimestamp - interval ?),
      localtimestamp,
      interval ?
    ) g(start_time)
    LEFT JOIN bit_coins btc ON btc.timestamp >= g.start_time AND btc.timestamp < g.start_time + interval ?
    GROUP  BY start_time
    ORDER  BY start_time;"
  )

  def self.query(category = 'minute')
    period = CATEGORY_HASH[category.to_sym][:period]
    duration = CATEGORY_HASH[category.to_sym][:duration]
    interval = CATEGORY_HASH[category.to_sym][:interval]
    BitCoin.find_by_sql([QUERY_STRING, period, duration, interval, interval])
  end
end
