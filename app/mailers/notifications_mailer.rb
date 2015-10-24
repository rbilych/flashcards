class NotificationsMailer < ApplicationMailer
  def pending_cards(user)
    @cards_count = user.cards.for_review.count
    @cards = "card".pluralize(@cards_count)

    mail(to: user.email,
         subject: "You have #{@cards_count} #{@cards} for review")
  end
end
