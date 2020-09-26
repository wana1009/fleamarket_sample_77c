class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                           null:false, index:true
      t.text :detail,                           null:false
      t.integer :price,                         null:false, index:true
      t.string :size
      t.references :condition,  type: :integer, null:false
      t.references :charge,     type: :integer, null:false
      t.references :prefecture, type: :integer, null:false
      t.references :day,        type: :integer, null:false
      t.references :seller,     type: :integer, null:false
      t.references :order,      type: :integer
      t.references :category,   type: :integer
      t.references :brand,      type: :integer
      t.timestamps
    end
  end
end