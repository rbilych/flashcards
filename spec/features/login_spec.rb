require "rails_helper"

feature "Log in" do
  let!(:user) do
    create(:user, email: "some@user.com", password: "123456", locale: "en")
  end

  scenario "registered user try log in" do
    login("some@user.com", "123456")

    expect(page).to have_content("Welcome back!")
  end
  scenario "non registered user try log in" do
    login("another@user.com", "123456")

    expect(page).to have_content("Email and/or password is incorrect")
  end
  scenario "user log out" do
    login("some@user.com", "123456")

    click_on "Log out"

    expect(page).to have_content("See you!")
  end
end
