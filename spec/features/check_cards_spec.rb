require "rails_helper"

feature "check cards" do
  given(:card) { build :card }

  before { card.save }

  scenario "user can see card if card exist" do
    visit root_path

    expect(page).to have_content(card.translated_text)
  end

  scenario "user can see warning if card don't exist" do
    card.destroy
    visit root_path

    expect(page).to have_content("Нет карточек для изучения")
  end

  scenario "user gives correct answer" do
    visit root_path

    fill_in "Answer", with: card.original_text
    click_on "Check"

    expect(page).to have_content("Good")
  end

  scenario "user gives correct answer with strange argument" do
    visit root_path

    fill_in "Answer", with: " oriGinAl  "
    click_on "Check"

    expect(page).to have_content("Good")
  end

  scenario "user gives incorrect answer" do
    visit root_path

    fill_in "Answer", with: "incorrect"
    click_on "Check"

    expect(page).to have_content("Bad")
  end
end
