class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null:false, index:true
      t.text :detail, null:false
      t.integer :price, null:false, index;true
      t.string :size
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.references :brand, foreign_key: true
      t.timestamps
    end
  end
end

