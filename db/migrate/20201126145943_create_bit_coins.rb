class CreateBitCoins < ActiveRecord::Migration[6.0]
  def change
    create_table :bit_coins do |t|
      t.decimal   :price, null: false, default: 0.00
      t.datetime  :timestamp, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps

      t.index :timestamp
    end
  end
end
