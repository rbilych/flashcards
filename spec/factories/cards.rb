FactoryGirl.define do
  factory :card do
    original_text "Original"
    translated_text "Translated"
    review_date Date.today
    user_id 1
  end
end
