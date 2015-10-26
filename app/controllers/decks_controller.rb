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
      flash[:notice] = t(".notice")
    else
      flash[:alert] = @deck.errors.full_messages.to_sentence
    end

    redirect_to decks_path
  end

  def edit
  end

  def update
    if @deck.update(deck_params)
      flash[:notice] = t(".notice")
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

  def set_current
    if current_user.update_attributes(current_deck_id: deck_params[:deck_id])
      flash[:notice] = t(".notice")
    end
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
