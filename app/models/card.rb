class Card < ActiveRecord::Base
  belongs_to :deck

  validates :original_text,
            :translated_text,
            :review_date,
            :deck_id,
            presence: true

  validate :text_fields_not_same

  scope :for_review, -> { where("review_date <= ?", Time.now).order("RANDOM()") }

  has_attached_file :image, styles: { original: "360x360#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def check_answer(answer)
    if prepare_string(answer) == prepare_string(original_text)
      change_box
      true
    else
      update(mistakes: mistakes + 1)
      reset_box if mistakes == 3
      false
    end
  end

  protected

  def change_box
    update(box: box + 1, mistakes: 0) if box < 5
    change_review_date
  end

  def reset_box
    update(box: 1, mistakes: 0)
    change_review_date
  end

  def change_review_date
    case box
    when 1
      time = 12.hours
    when 2
      time = 3.days
    when 3
      time = 1.week
    when 4
      time = 2.weeks
    when 5
      time = 1.month
    end

    update(review_date: Time.now + time)
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
