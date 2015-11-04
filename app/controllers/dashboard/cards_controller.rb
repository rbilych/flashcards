class Dashboard::CardsController < ApplicationController
  before_action :find_card, only: [:show, :edit, :update, :destroy]
  before_action :find_deck, only: [:update, :destroy]

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    if deck_params[:title].blank?
      @card = current_user.cards.build(card_params)
      @deck = current_user.decks.find(@card.deck_id)
    else
      @deck = current_user.decks.create(deck_params)
      @card = @deck.cards.build(card_params)
    end

    if @card.save
      redirect_to @deck
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @deck
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to @deck
  end

  private

  def find_card
    @card = current_user.cards.find(params[:id])
  end

  def find_deck
    @deck = current_user.decks.find(@card.deck_id)
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
