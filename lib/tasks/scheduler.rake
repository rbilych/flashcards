task send_cards_notify: :environment do
  Card.send_pending_cards_notify
end
