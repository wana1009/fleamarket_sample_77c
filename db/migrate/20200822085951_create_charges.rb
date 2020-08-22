class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.integer :charge_id
      t.string :charge

      t.timestamps
    end
  end
end
