class UpdateBitCoinPrice
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false

  def perform
    bit_coin = BitCoinService.bit_coin_detail
    puts "======="
    bit_coin
    puts "======="
    BitCoin.create!(bit_coin)

    ActionCable.server.broadcast(
      'bit_coin_channel', {
        type: 'minute',
        data: BitCoinQuery.query('minute')
      }
    )
  end
end
