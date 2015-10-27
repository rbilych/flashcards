class NotificationsMailer < ApplicationMailer
  def pending_cards(user)
    @cards_count = user.cards.for_review.count
    @cards = t("email.card", count: @cards_count)

    I18n.with_locale(user.locale) do
      mail(to: user.email,
           subject: t("notifications_mailer.pending_cards.subject",
                      count: @cards_count, cards: @cards))
    end
  end
end
