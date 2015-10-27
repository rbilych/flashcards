require "rails_helper"

feature "Decks" do
  let!(:user) do
    create(:user, email: "some@user.com", password: "123456", locale: "en")
  end
  let!(:deck) { create(:deck, user_id: user.id) }

  before(:each) do
    login("some@user.com", "123456")
  end

  scenario "user can create deck" do
    visit decks_path

    click_on "Add new deck"
    fill_in "New deck name", with: "My Deck"
    click_on "Create Deck"

    expect(page).to have_content("My Deck")
  end

  scenario "user can edit deck" do
    visit decks_path

    click_on "Edit"
    fill_in "New deck name", with: "New Deck"
    click_on "Update Deck"

    expect(page).to have_content("New Deck")
  end

  scenario "user can delete deck" do
    visit decks_path

    click_on "Delete"

    expect(page).to_not have_content(deck.title)
  end

  scenario "user can change current state of deck" do
    visit decks_path

    click_on "Make current"

    expect(page).to have_content("Current")
  end
end
