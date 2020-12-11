class UpdateBitCoinPrice
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false

  def perform
    puts "====="
    puts BitCoin.create!(BitCoinService.bit_coin_detail).inspect
    puts "====="

    ActionCable.server.broadcast(
      'bit_coin_channel', {
        type: 'minute',
        data: BitCoinQuery.query('minute')
      }
    )
  end
end
