class BitCoinsController < ApplicationController
  def index
    # default is per hour
    bitCoins = {}
    BitCoinQuery::CATEGORY_HASH.keys.each do |category|
      bitCoins[category] = BitCoinQuery.query(category)
    end
    @bit_coins = { bitCoins: bitCoins }
  end
end
