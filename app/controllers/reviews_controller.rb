class ReviewsController < ApplicationController
  skip_before_action :require_login

  def new
    if logged_in?
      if current_user.current_deck
        @card = current_user.current_deck.cards.for_review.first
      else
        @card = current_user.cards.for_review.first
      end
    end
  end

  def create
    @card = Card.find(review_params[:card_id])

    answer = @card.check_answer(review_params[:answer])

    if answer[:result]
      flash[:notice] = t ".correct"
    elsif answer[:typos]
      flash[:alert] = t(".typo",
                        answer: review_params[:answer],
                        typo: @card.original_text)
    else
      flash[:alert] = t ".mistake"
    end

    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :answer)
  end
end
