module FeatureHelper
  def login(email, password)
    visit log_in_path

    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Log in"
  end

  def signup(email, password)
    visit root_path

    within ".nav" do
      click_on "Sign Up"
    end
    fill_in "Email", with: email
    fill_in "Password", with: password, match: :prefer_exact
    fill_in "Password confirmation", with: password
    click_on "Create Account"
  end
end
