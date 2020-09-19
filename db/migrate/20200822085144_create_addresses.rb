class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string   :first_name,           null: false
      t.string   :last_name,            null: false
      t.string   :first_kana,           null: false
      t.string   :last_kana,            null: false
      t.string   :postal_code,          null: false
      t.references    :prefecture, type: :integer,          null: false
      t.string   :town,                 null: false
      t.string   :house_number,         null: false
      t.string   :building_name,        null: false
      t.string   :phone_number,         unique: true
      t.references :user, type: :integer
      t.timestamps
    end
  end
end