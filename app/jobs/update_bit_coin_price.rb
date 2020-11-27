class UpdateBitCoinPrice
  include Sidekiq::Worker

  def perform
    puts "I am here"
    # MINIMUM_PRICE_IN_LAST_YEAR = 8_500
    # MAXIMUM_PRICE_IN_LAST_YEAR = 20_000

    # bitcoin = BitCoin.create!(
    #   timestamp: Time.now,
    #   price: rand(MINIMUM_PRICE_IN_LAST_YEAR..MAXIMUM_PRICE_IN_LAST_YEAR)
    # )
  end
end