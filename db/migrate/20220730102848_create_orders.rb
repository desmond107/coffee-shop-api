class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.float :amount
      t.integer :user_id
      t.integer :coffee_id
    end
  end
end
