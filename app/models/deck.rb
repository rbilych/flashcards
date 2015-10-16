class Deck < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :user
  has_many :cards, dependent: :destroy
end
