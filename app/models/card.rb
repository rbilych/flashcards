class Card < ActiveRecord::Base
  TIME = [12.hours, 3.days, 1.week, 2.weeks, 1.month]

  belongs_to :deck

  validates :original_text,
            :translated_text,
            :review_date,
            :deck_id,
            presence: true

  validate :text_fields_not_same

  scope :for_review, lambda {
    where("review_date <= ?", Time.now.getlocal).order("RANDOM()")
  }

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
    update(review_date: Time.now.getlocal + TIME[box - 1])
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
