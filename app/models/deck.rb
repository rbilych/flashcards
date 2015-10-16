class Deck < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user
  has_many :cards, dependent: :destroy

  def change_current
    update(current: true)
    Deck.where("id != ?", id).update_all("current = 'false'")
  end
end
