class StaticPagesController < ApplicationController
  def index
    @card = Card.rand_card.first
  end

  def answer
    alert = Card.check_answer params[:answer],
                              params[:original_text],
                              params[:current_card_id]

    redirect_to root_path, alert: alert
  end
end
