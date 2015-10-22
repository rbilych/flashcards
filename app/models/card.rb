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
    if (result = prepare_string(answer) == prepare_string(original_text))
      b = box < 5 ? box + 1 : box
    else
      typos = typos_count(answer, original_text)
      return { result: false, typos: true } if typos <= 2

      update(mistakes: mistakes + 1)
      b = mistakes == 3 ? 1 : false
    end

    change_review_date(b)

    { result: result, typos: false }
  end

  protected

  def typos_count(answer, original_text)
    DamerauLevenshtein.distance(prepare_string(answer),
                                prepare_string(original_text), 0)
  end

  def change_review_date(b)
    if b
      time = Time.now.getlocal + TIME[b - 1]
      update(box: b, mistakes: 0, review_date: time)
    end
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
