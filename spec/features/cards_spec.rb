require "rails_helper"

feature "Cards" do
  let!(:user) { create(:user, email: "some@user.com", password: "123456", locale: "en") }
  let!(:deck) { create(:deck, user_id: user.id) }

  before(:each) do
    login("some@user.com", "123456")
  end

  scenario "user can see only own cards" do
    deck2 = create(:deck, user_id: 42)
    create(:card, deck_id: deck2.id)

    visit cards_path

    expect(page).to_not have_css(".card")
  end

  scenario "user can't see other cards" do
    deck2 = create(:deck, user_id: 42)
    card = create(:card, deck_id: deck2.id)

    expect do
      visit card_path(card)
    end.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario "user can create cards" do
    click_on "Add new card"
    fill_in "Original text", with: "Original"
    fill_in "Translated text", with: "Translated"
    click_on "Create Card"

    expect(page).to have_content("Original text: Original")
    expect(page).to have_content("Translated text: Translated")
  end

  scenario "user can edit cards" do
    create(:card, deck_id: deck.id)

    visit cards_path
    click_on "Edit"
    fill_in "Original text", with: "New"
    click_on "Update Card"

    expect(page).to have_content("Original text: New")
  end

  scenario "user can delete cards" do
    create(:card, deck_id: deck.id)

    visit cards_path
    click_on "Delete"

    expect(page).to_not have_css(".card")
  end

  scenario "user can create deck from new card form" do
    visit new_card_path

    fill_in "New deck name", with: "New Deck"
    fill_in "Original text", with: "Original"
    fill_in "Translated text", with: "Translated"
    click_on "Create Card"

    visit decks_path

    expect(page).to have_content("New Deck (1)")
  end
end
