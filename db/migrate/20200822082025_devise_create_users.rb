class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname,           null: false
      t.string :email,              null: false, unique: true, default: ""
      t.string :password,           null: false, default: ""
      t.first_name :string,         null: false
      t.last_name :string,          null: false
      t.first_kana :string,         null: false
      t.last_kana :string,          null: false
      t.birthday :date,             null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
