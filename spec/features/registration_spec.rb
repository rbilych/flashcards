require "rails_helper"

feature "Registration" do
  scenario "user register with valid data" do
    signup("some@user.com", "123456")

    expect(page).to have_content("Welcome!")
  end

  scenario "user register with invalid data" do
    signup(nil, nil)

    expect(page).to have_content("Registration")
  end
end
