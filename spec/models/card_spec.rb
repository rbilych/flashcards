require "rails_helper"

describe Card do
  context "validation" do
    it "has valid factory" do
      expect(build(:card)).to be_valid
    end

    it "is invalid without original text" do
      card = build(:card, original_text: "")

      expect(card).to_not be_valid
    end

    it "is invalid without translated text" do
      card = build(:card, translated_text: "")

      expect(card).to_not be_valid
    end

    it "is invalid with same texts" do
      card = build(:card, translated_text: "Original")

      expect(card).to_not be_valid
    end

    it "is invalid with same texts and with strange argument" do
      card = build(:card, translated_text: " oriGinAl  ")

      expect(card).to_not be_valid
    end
  end

  context "check answer" do
    let!(:card) { create(:card) }

    it "change box if correct answer" do
      5.times do |i|
        time = (Time.now.getlocal + Card::TIME[i]).utc.beginning_of_hour

        card.check_answer("Original")

        expect(card.box).to eq i + 1
        expect(card.mistakes).to eq 0
        expect(card.review_date.beginning_of_hour).to eq time
      end
    end

    it "don't change box if box == 5" do
      time = (Time.now.getlocal + 1.month).utc.beginning_of_hour
      card.box = 5

      card.check_answer("Original")

      expect(card.box).to eq 5
      expect(card.review_date.beginning_of_hour).to eq time
    end

    it "reset box if 3 times incorrect answer" do
      time = (Time.now.getlocal + 12.hours).utc.beginning_of_hour

      3.times { card.check_answer("Incorrect") }

      expect(card.box).to eq 1
      expect(card.mistakes).to eq 0
      expect(card.review_date.beginning_of_hour).to eq time
    end
  end
end
