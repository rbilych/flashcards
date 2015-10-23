task send_cards_notify: :environment do
  Card.send_notify
end
