module FeatureHelper
  def login(email, password)
    visit log_in_path

    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log In"
  end

  def signup(email, password)
    visit root_path

    within ".nav" do
      click_on "Sign Up"
    end
    fill_in "Email", with: email
    fill_in "Password", with: password, match: :prefer_exact
    fill_in "Confirm Password", with: password
    find("#registration_locale").set("en")
    click_on "Create Account"
  end
end
