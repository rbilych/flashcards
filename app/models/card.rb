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

  def check_answer(answer, time)
    unless (result = prepare_string(answer) == prepare_string(original_text))
      typos = typos_count(answer, original_text)

      return { result: false, typos: true } if typos <= 2

      time = -1
      result = false
    end

    super_memo = SuperMemo.new(time, iteration, factor)

    change_review_date(super_memo.calculation)

    { result: result, typos: false }
  end

  protected

  def typos_count(answer, original_text)
    DamerauLevenshtein.distance(prepare_string(answer),
                                prepare_string(original_text), 0)
  end

  def change_review_date(super_memo)
    date = Time.now.getlocal + super_memo[:interval].days

    update(iteration: super_memo[:iteration],
           factor: super_memo[:factor],
           review_date: date)
  end

  def text_fields_not_same
    if prepare_string(original_text) == prepare_string(translated_text)
      errors.add(:original_text, I18n.t("cards.errors.same_fields"))
    end
  end

  def prepare_string(string)
    string.mb_chars.downcase.strip
  end
end
