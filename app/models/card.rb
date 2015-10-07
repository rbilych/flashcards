class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_fields_not_same

  before_validation on: :create do
    self.review_date ||= change_review_date
  end

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

  def self.change_review_date
    3.days.from_now
  end

  protected

  def text_fields_not_same
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:original_text,
                 "Оригинальный текст не должен быть равен переведенному")
    end
  end
end
