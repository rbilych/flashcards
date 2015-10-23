class NotificationsMailer < ApplicationMailer
  def pending_cards
    User.all.each do |user|
      @cards_count = user.cards.for_review.count

      if @cards_count > 0
        @cards = "card".pluralize(@cards_count)
        mail(to: user.email,
             subject: "You have #{@cards_count} #{@cards} for review")
      end
    end
  end
end
