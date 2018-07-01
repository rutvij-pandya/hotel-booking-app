class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.belongs_to :booking
      t.string "stripe_token", null: false
      t.string "charge_id"
      t.integer "amount", default: 0
      t.integer "status", limit: 1, default: Payment.statuses[:pending]
      t.jsonb "transaction_data"
      t.timestamps
    end
  end
end
