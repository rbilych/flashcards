require "rails_helper"

describe NotificationsMailer do
  context "send pending cards notify" do
    let!(:user) { create(:user, locale: "en") }
    let!(:deck) { create(:deck, user_id: user.id) }

    it "can send email" do
      NotificationsMailer.pending_cards(user).deliver_later

      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it "send email if cards for review exist" do
      create(:card, deck_id: deck.id)

      User.send_pending_cards_notify

      email = ActionMailer::Base.deliveries.first

      expect(email.from[0]).to eq ENV["EMAIL_FROM"]
      expect(email.to[0]).to eq user.email
      expect(email.subject).to eq "You have 1 card for review"
      expect(email).to have_text "Hello! You have 1 card for review"
    end

    it "don't send email if no cards for review" do
      User.send_pending_cards_notify

      expect(ActionMailer::Base.deliveries.count).to eq 0
    end
  end
end
