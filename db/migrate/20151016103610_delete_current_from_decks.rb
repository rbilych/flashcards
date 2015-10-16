class DeleteCurrentFromDecks < ActiveRecord::Migration
  def change
    remove_column :decks, :current
  end
end
