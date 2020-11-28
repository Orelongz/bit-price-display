class UpdateBitCoinPrice
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false

  VARIATION = 3_500.00

  def perform
    bitcoin = BitCoin.create!(bit_coin_detail)

    ActionCable.server.broadcast(
      'bit_coin_channel', {
        type: 'minute',
        data: BitCoinQuery.query('minute')
      }
    )
  end

  def bit_coin_detail
    begin
      uri = URI.parse('https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=BTC')
      request = Net::HTTP::Get.new(uri)
      request['X-Cmc_pro_api_key'] = Rails.application.credentials.dig(:coin_market, :api_key)
      request['Accept'] = 'application/json'
  
      req_options = {
        use_ssl: uri.scheme == 'https',
      }

      # response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      #   http.request(request)
      # end

      details = JSON(response.body)['data']['BTC']['quote']['USD']
  
      {
        price: details['price'],
        timestamp: details['last_updated']
      }
    rescue => exception
      price = BitCoin.order(:timestamp).last.price + rand(-VARIATION..VARIATION)
      {
        price: price,
        timestamp: Time.now
      }
    end
  end
end
