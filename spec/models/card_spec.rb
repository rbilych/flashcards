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

    before :each do
      card.check_answer("Original", 1)
    end

    it "change iteration if correct answer" do
      expect(card.iteration).to eq 2
    end

    it "reset iteration if incorrect answer" do
      card.check_answer("Incorrect", 1)

      expect(card.iteration).to eq 1
    end

    it "change review date" do
      time = (Time.now.getlocal + 1.day).utc.beginning_of_hour
      expect(card.review_date.beginning_of_hour).to eq time

      card.check_answer("Original", 1)

      time = (Time.now.getlocal + 6.day).utc.beginning_of_hour
      expect(card.review_date.beginning_of_hour).to eq time
    end
  end
end
