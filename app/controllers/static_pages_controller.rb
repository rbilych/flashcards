class StaticPagesController < ApplicationController
  before_action :find_card
  def index
  end

  def answer
    alert = @card.check_answer params[:answer]

    redirect_to root_path, alert: alert
  end

  private

  def find_card
    @card = Card.for_review.first
  end
end
