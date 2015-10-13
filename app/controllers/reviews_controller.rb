class ReviewsController < ApplicationController
  skip_before_filter :require_login, only: [:new]

  def new
    @card = current_user.cards.for_review.first if logged_in?
  end

  def create
    @card = Card.find(review_params[:card_id])

    if @card.check_answer(review_params[:answer])
      flash[:notice] = "Good"
    else
      flash[:alert] = "Bad"
    end

    redirect_to root_path
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :answer)
  end
end
