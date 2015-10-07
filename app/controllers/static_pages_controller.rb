class StaticPagesController < ApplicationController
  before_action :find_card

  def index
  end

  def answer
    @cards.each_with_index do |card, index|
      @alert = card.check_answer params[:answer][index],
                                 params[:original_text][index]
      flash[:alert] ||= []
      flash[:alert] << @alert
    end

    redirect_to root_path
  end

  private

  def find_card
    @cards = Card.for_review(1)
  end
end
