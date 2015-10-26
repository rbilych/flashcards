class NotificationsMailer < ApplicationMailer
  def pending_cards(user)
    @cards_count = user.cards.for_review.count
    @cards = t("email.card", count: @cards_count)

    mail(to: user.email,
         subject: default_i18n_subject(count: @cards_count, cards: @cards))
  end
end
