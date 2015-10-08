class StaticPagesController < ApplicationController
  def index
    @card = Card.for_review.first
  end

  def answer
    @card = Card.find(params[:card_id])

    if @card.check_answer(params[:answer])
      flash[:alert] = "Good"
    else
      flash[:alert] = "Bad"
    end

    redirect_to root_path
  end
end
