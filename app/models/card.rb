class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_fields_not_same

  after_initialize do
    self.review_date ||= 3.days.from_now
  end

  protected

  def text_fields_not_same
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:original_text,
                 'Оригинальный текст не должен быть равен переведенному')
    end
  end
end
