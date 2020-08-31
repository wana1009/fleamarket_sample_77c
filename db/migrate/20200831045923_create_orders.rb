class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, type: :integer, null:false
      t.references :item, type: :integer, null:false
      t.timestamps
    end
  end
end
