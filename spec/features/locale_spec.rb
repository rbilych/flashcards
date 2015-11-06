require "rails_helper"

feature "Localization" do
  scenario "guest can change site language" do
    visit root_path

    click_on "RU"
    expect(page).to have_content "Веб приложение для запоминания"

    click_on "UK"
    expect(page).to have_content "Веб застосунок для запамятовування"

    click_on "EN"
    expect(page).to have_content "Web application for learning"
  end
end
