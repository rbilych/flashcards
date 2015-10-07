class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_fields_not_same

  before_validation :change_review_date, on: :create

  scope :for_review, -> {
    where("review_date <= :today", today: Date.today).
    order("RANDOM()").
    limit(1)
  }

  def check_answer(answer)
    if answer.downcase.strip == self.original_text.downcase.strip
      self.update(review_date: 3.days.from_now)
      "Правильно"
    else
      "Неправильно"
    end
  end

  protected

  def change_review_date
    self.review_date ||= 3.days.from_now
  end

  def text_fields_not_same
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:original_text,
                 "Оригинальный текст не должен быть равен переведенному")
    end
  end
end
