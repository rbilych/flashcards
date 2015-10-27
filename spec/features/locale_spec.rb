require "rails_helper"

feature "Localization" do
  scenario "guest can change site language" do
    visit root_path

    click_on "RU"
    expect(page).to have_content "Первый в мире удобный менеджер"

    click_on "EN"
    expect(page).to have_content "The world's first"
  end
end
