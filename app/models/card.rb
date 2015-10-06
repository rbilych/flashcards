class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :text_fields_not_same

  protected

  def text_fields_not_same
    if original_text.downcase == translated_text.downcase
      errors.add(:original_text,
                 'Оригинальный текст не должен быть равен переведенному')
    end
  end
end
