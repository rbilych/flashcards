class AddMistakesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :mistakes, :integer, default: 0
  end
end
