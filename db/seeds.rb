# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


BATCH_LENGTH = 2_000
bit_coin = BitCoinService.bit_coin_detail

# seed a year worth of data
# 60 minutes, 24 hours, 356 days
MINUTES_IN_A_YEAR = (60 * 24 * 356) + 1000

(1..MINUTES_IN_A_YEAR).each_slice(BATCH_LENGTH) do |arr|
  data = []

  arr.map do
    data << BitCoin.new(bit_coin)
    bit_coin[:timestamp] -= 1.minutes
    bit_coin[:price] = BitCoinService.estimated_price
  end

  puts "Importing batch of #{BATCH_LENGTH}"
  BitCoin.import(data)
end

puts "Database seed completed"
