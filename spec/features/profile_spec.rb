require "rails_helper"

feature "Profile" do
  let!(:user) do
    create(:user, email: "some@user.com", password: "123456", locale: "en")
  end

  before(:each) do
    login("some@user.com", "123456")
  end

  scenario "user successfully edit profile" do
    click_on "Edit profile"
    fill_in "Email", with: "new_mail@user.com"
    fill_in "Password", with: "654321", match: :prefer_exact
    fill_in "Confirm Password", with: "654321"
    click_on "Update Profile"

    expect(page).to have_content("Your profile was updated successfully!")
  end

  scenario "user unsuccessfully edit profile" do
    click_on "Edit profile"
    fill_in "Email", with: ""
    click_on "Update Profile"

    expect(page).to have_content("Your profile was not updated!")
  end
end
