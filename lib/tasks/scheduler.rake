task send_cards_notify: :environment do
  User.send_pending_cards_notify
end
