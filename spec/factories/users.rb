FactoryGirl.define do
  factory :user do
    email "some@user.com"
    password "123456"
    password_confirmation "123456"
  end
end
