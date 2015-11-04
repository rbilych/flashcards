# every :day, at: "9am" do
every 5.minutes do
  runner "User.send_pending_cards_notify"
end
