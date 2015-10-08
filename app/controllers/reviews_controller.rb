class ReviewsController < ApplicationController
  def new
    @card = Card.for_review.first
  end

  def update
    @card = Card.find(review_params[:card_id])

    if @card.check_answer(review_params[:answer])
      flash[:alert] = "Good"
    else
      flash[:alert] = "Bad"
    end

    redirect_to root_path
  end

  private

  def review_params
    params.permit(:card_id, :answer)
  end
end
