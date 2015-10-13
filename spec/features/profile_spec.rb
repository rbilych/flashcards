require "rails_helper"

feature "Profile" do
  let!(:user) { create(:user, email: "some@user.com", password: "123456") }

  before(:each) do
    login("some@user.com", "123456")
  end

  scenario "user successfully edit profile" do
    click_on "Profile"
    fill_in "Email", with: "new_mail@user.com"
    fill_in "Password", with: "654321", match: :prefer_exact
    fill_in "Password confirmation", with: "654321"
    click_on "Update User"

    expect(page).to have_content("Updated")
  end

  scenario "user unsuccessfully edit profile" do
    click_on "Profile"
    click_on "Update User"

    expect(page).to have_content("Not updated")
  end
end
