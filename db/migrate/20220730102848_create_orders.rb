class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.float :amount
      t.integer :user_id
      t.string :order, array: true, default: []
    end
  end
end
