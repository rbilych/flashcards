class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_fields_not_same

  before_validation :change_review_date, on: :create

  def self.for_review(count)
    where("review_date <= ?", Date.today).
    order("RANDOM()").
    limit(count)
  end

  def check_answer(answer, original_text)
    if answer.mb_chars.downcase.strip == original_text.mb_chars.downcase.strip
      self.update(review_date: 3.days.from_now)
      true
    else
      false
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
