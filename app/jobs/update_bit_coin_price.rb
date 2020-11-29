class UpdateBitCoinPrice
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: false

  def perform
    bitcoin = BitCoin.create!(BitCoinService.bit_coin_detail)

    ActionCable.server.broadcast(
      'bit_coin_channel', {
        type: 'minute',
        data: BitCoinQuery.query('minute')
      }
    )
  end
end
