class DecksController < ApplicationController
  before_action :find_deck, only: [:show, :edit, :update, :destroy]
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

  def edit
  end

  def update
    if @deck.update(deck_params)
      flash[:notice] = "Deck udated"
      redirect_to decks_path
    else
      flash[:alert] = @deck.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  def change_current_state
    deck = Deck.find(deck_params[:deck_id])

    deck.change_current

    flash[:notice] = "Current deck was changed"
    redirect_to decks_path
  end

  private

  def find_deck
    @deck = current_user.decks.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:title, :deck_id)
  end
end
