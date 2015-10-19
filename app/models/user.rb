class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, presence: true

  validates :password, length: { minimum: 6 },
    if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true,
    if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true,
    if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true
  validates :password, confirmation: true

  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :decks, dependent: :destroy

  accepts_nested_attributes_for :authentications

  belongs_to :current_deck, class_name: "Deck", foreign_key: "current_deck_id"
end
