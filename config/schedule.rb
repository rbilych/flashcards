every :day, at: "9am" do
  runner "User.send_pending_cards_notify"
end
