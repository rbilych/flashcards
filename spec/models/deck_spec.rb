require 'rails_helper'

describe Deck do
  let!(:deck1) { create(:deck, title: "first", current: false) }
  let!(:deck2) { create(:deck, title: "second", current: true) }

  it "change current state of deck" do
    deck1.change_current

    deck1.reload
    deck2.reload

    expect(deck1.current).to be true
    expect(deck2.current).to be false
  end
end
