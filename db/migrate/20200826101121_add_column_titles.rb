class AddColumnTitles < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :purchase_id, :string
  end
end
