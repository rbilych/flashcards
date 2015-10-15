FactoryGirl.define do
  factory :card do
    deck_id 1
    original_text "Original"
    translated_text "Translated"
    review_date Date.today
    user_id 1
  end
end
