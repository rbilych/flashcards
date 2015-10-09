require 'rails_helper'

describe Card do
  context 'validation' do
    it 'has valid factory' do
      expect(build(:card)).to be_valid
    end

    it 'is invalid without original text' do
      card = build(:card, original_text: '')

      expect(card).to_not be_valid
    end

    it 'is invalid without translated text' do
      card = build(:card, translated_text: '')

      expect(card).to_not be_valid
    end

    it 'is invalid with same texts' do
      card = build(:card, translated_text: 'Original')

      expect(card).to_not be_valid
    end

    it 'is invalid with same texts and with strange argument' do
      card = build(:card, translated_text: ' oriGinAl  ')

      expect(card).to_not be_valid
    end
  end

  it 'change review date on create' do
    card = build(:card, review_date: nil)
    card.save

    expect(card.review_date).to eq (Date.today + 3.days)
  end

  context 'check answer' do
    let(:card) { build(:card) }

    it 'add +3 days and returnt true' do
      expect(card.check_answer("Original")).to be true
      expect(card.review_date).to eq (Date.today + 3.days)
    end

    it 'add +3 days and returnt true with strange argument' do
      expect(card.check_answer(" oriGinAl  ")).to be true
      expect(card.review_date).to eq (Date.today + 3.days)
    end

    it 'dont change date and returns false' do
      expect(card.check_answer("foo")).to be false
      expect(card.review_date).to eq Date.today
    end
  end
end
