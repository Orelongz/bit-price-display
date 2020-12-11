class BitCoinService
  VARIATION = 100.00

  def self.bit_coin_detail
    begin
      uri = URI.parse('https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=BTC')
      request = Net::HTTP::Get.new(uri)
      request['X-Cmc_pro_api_key'] = Rails.application.credentials.dig(:coin_market, :api_key)
      request['Accept'] = 'application/json'
  
      req_options = {
        use_ssl: uri.scheme == 'https',
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      details = JSON(response.body)['data']['BTC']['quote']['USD']
  
      {
        price: details['price'],
        timestamp: details['last_updated']
      }
    rescue Exception => e
      {
        price: estimated_price,
        timestamp: Time.now
      }
    end
  end

  def self.estimated_price
    (BitCoin.order(:timestamp).last.try(:price)  || 17_752.36) + rand(-VARIATION..VARIATION)
  end
end