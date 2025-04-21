class CardsController < ApplicationController
  def index
    @cards = Card.all
    render :index
  end
  
  def show
    @card = Card.find(params[:card_id])
    render :show
  end
end
