class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name,           null: false
      t.string :last_name,            null: false
      t.string :first_kana,           null: false
      t.string :last_kana,            null: false
      t.string :postal_code,          null: false
      t.integer :prefecture_id,       null: false
      t.string :address1,             null: false
      t.string :address2,             null: false
      t.string :building_name,        null: false
      t.string :phone_number,         unique: true
      t.references :user_id           foreign_key: true




      t.timestamps
    end
  end
end
