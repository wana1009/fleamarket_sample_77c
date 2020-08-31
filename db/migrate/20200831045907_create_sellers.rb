class CreateSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :sellers do |t|
      t.references :user, type: :integer, null:false
      t.references :item, type: :integer, null:false
      t.integer :revenue
      t.integer :profit
      t.timestamps
    end
  end
end
