class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true

  has_many :cards
end
