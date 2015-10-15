class Deck < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user
  has_many :cards, dependent: :destroy

  def change_current
    self.update(current: true)
    Deck.where("id != ?", self.id).update_all("current = 'false'")
  end
end
