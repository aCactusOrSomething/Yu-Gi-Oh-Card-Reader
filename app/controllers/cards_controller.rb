class CardsController < ApplicationController
  def index
    @term = params[:query]
    clean_term =  @term.upcase.gsub(/[^\x00-\x7F]/, ' ')
    @cards = []
    for card in Card.all
      if card.name_searchable.include? clean_term
        @cards.push(card)
      end
    end
    render :index
  end

  def show
    @card = Card.find(params[:card_id])
    render :show
  end

end
