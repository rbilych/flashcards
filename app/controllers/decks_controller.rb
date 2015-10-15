class DecksController < ApplicationController
  before_action :find_deck, only: [:show]
  def index
    @decks = current_user.decks
  end

  def show
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.build(deck_params)

    if @deck.save
      flash[:notice] = "Deck added"
    else
      flash[:alert] = @deck.errors.full_messages.to_sentence
    end

    redirect_to decks_path
  end

  private

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title)
  end
end
