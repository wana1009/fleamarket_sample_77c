class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.integer :day_id
      t.string :day

      t.timestamps
    end
  end
end
