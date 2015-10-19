class CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.cards
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    if deck_params[:title].blank?
      @card = current_user.cards.build(card_params)
    else
      @deck = current_user.decks.create(deck_params)
      @card = @deck.cards.build(card_params.merge(user_id: current_user.id))
    end

    if @card.save
      redirect_to @card
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def find_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text,
                                 :translated_text,
                                 :review_date,
                                 :image,
                                 :deck_id)
  end

  def deck_params
    params.require(:deck).permit(:title)
  end
end
