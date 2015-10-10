class Card < ActiveRecord::Base
  belongs_to :user

  validates :original_text, :translated_text, :review_date, :user_id, presence: true
  validate :text_fields_not_same

  before_validation :change_review_date, on: :create

  scope :for_review, -> { where("review_date <= ?", Date.today).
                          order("RANDOM()") }

  def check_answer(answer)
    if prepare_string(answer) == prepare_string(original_text)
      update(review_date: Date.today + 3.days)
    else
      false
    end
  end

  protected

  def change_review_date
    self.review_date ||= Date.today + 3.days
  end

  def text_fields_not_same
    if prepare_string(original_text) == prepare_string(translated_text)
      errors.add(:original_text,
                 "Оригинальный текст не должен быть равен переведенному")
    end
  end

  def prepare_string(string)
    string.mb_chars.downcase.strip
  end
end
