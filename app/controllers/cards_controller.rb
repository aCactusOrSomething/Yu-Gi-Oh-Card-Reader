# frozen_string_literal: true

class CardsController < ApplicationController
  def index
    @term = params[:query]
    clean_term = @term.upcase.gsub(/[^\x00-\x7F]/, ' ')
    @cards = []
    Card.all.find_each do |card|
      @cards.push(card) if card.name_searchable.include? clean_term
    end
    render :index
  end

  def show
    @card = Card.find(params[:card_id])
    render :show
  end
end
