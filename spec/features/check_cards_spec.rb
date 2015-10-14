require "rails_helper"

feature "check cards" do
  let!(:user) { create(:user, email: "some@user.com", password: "123456") }
  let!(:card) { create(:card, user_id: user.id) }

  before(:each) do
    login("some@user.com", "123456")
  end

  scenario "user can see card if card for review exist" do
    expect(page).to have_content(card.translated_text)
  end

  scenario "user can see warning if card don't exist" do
    card.destroy
    visit root_path

    expect(page).to have_content("Нет карточек для изучения")
  end

  scenario "user gives correct answer" do
    fill_in "Answer", with: card.original_text
    click_on "Check"

    expect(page).to have_content("Good")
  end

  scenario "user gives correct answer with strange argument" do
    fill_in "Answer", with: " oriGinAl  "
    click_on "Check"

    expect(page).to have_content("Good")
  end

  scenario "user gives incorrect answer" do
    fill_in "Answer", with: "incorrect"
    click_on "Check"

    expect(page).to have_content("Bad")
  end
end
