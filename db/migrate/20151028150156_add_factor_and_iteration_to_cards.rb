class AddFactorAndIterationToCards < ActiveRecord::Migration
  def change
    remove_column :cards, :box
    remove_column :cards, :mistakes

    add_column :cards, :iteration, :integer, default: 1
    add_column :cards, :factor, :float, default: 2.5
  end
end
