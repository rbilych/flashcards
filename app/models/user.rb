class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  validates :email, :locale, presence: true

  with_options if: -> { new_record? || changes["password"] } do
    validates :password, length: { minimum: 6 }
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
  end

  validates :email, uniqueness: true

  has_many :authentications, dependent: :destroy
  has_many :cards, through: :decks
  has_many :decks, dependent: :destroy

  accepts_nested_attributes_for :authentications

  belongs_to :current_deck, class_name: "Deck", foreign_key: "current_deck_id"

  def self.send_pending_cards_notify
    where.not(email: nil).includes(:cards).each do |user|
      if user.cards.for_review.count > 0
        NotificationsMailer.pending_cards(user).deliver_later
      end
    end
  end
end
