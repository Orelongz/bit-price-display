# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


BATCH_LENGTH = 2_000
MINIMUM_PRICE_IN_LAST_YEAR = 8_500
MAXIMUM_PRICE_IN_LAST_YEAR = 20_000

# seed a year worth of data
# 60 minutes, 24 hours, 356 days
MINUTES_IN_A_YEAR = (60 * 24 * 356) + 1000

timestamp = Time.now
(1..MINUTES_IN_A_YEAR).each_slice(BATCH_LENGTH) do |arr|
  data = []

  arr.map do
    data << BitCoin.new(
      timestamp: timestamp,
      price: rand(MINIMUM_PRICE_IN_LAST_YEAR..MAXIMUM_PRICE_IN_LAST_YEAR)
    )
    timestamp -= 1.minutes
  end

  puts "Importing batch of #{BATCH_LENGTH}"
  BitCoin.import(data)
end
