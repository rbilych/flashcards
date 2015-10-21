class AddBoxToCards < ActiveRecord::Migration
  def change
    add_column :cards, :box, :integer, default: 0
  end
end
