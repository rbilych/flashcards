class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :title
      t.boolean :current
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
