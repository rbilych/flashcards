class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_fields_not_same

  before_validation :change_review_date, on: :create

  scope :for_review, -> { where("review_date <= ?", Date.today).
                          order("RANDOM()") }

  def check_answer(answer)
    if answer.mb_chars.downcase.strip == original_text.mb_chars.downcase.strip
      update(review_date: (Date.today + 3.days))
    else
      false
    end
  end

  protected

  def change_review_date
    self.review_date ||= (Date.today + 3.days)
  end

  def text_fields_not_same
    original = original_text.mb_chars.downcase.strip
    translated = translated_text.mb_chars.downcase.strip

    if original  == translated
      errors.add(:original_text,
                 "Оригинальный текст не должен быть равен переведенному")
    end
  end
end
