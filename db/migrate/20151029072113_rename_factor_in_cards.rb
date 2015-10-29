class RenameFactorInCards < ActiveRecord::Migration
  def change
    rename_column :cards, :factor, :e_factor
  end
end
