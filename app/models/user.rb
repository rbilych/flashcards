class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true

  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :decks, dependent: :destroy

  accepts_nested_attributes_for :authentications

  def current_deck
    self.decks.where(current: true).first
  end
end
