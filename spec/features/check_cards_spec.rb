require "rails_helper"

feature "check cards" do
  given(:card) { build :card }

  before do
    card.save
    visit root_path
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
