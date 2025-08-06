class CardsController < ApplicationController

  def index
    @cards = Card.all
    @term = params[:name_searchable]

    params.each do |key, value|
      if not value == nil and not key == "commit" and not key == "controller" and not key == "action" and not value == 0 and not value == ''
        new_cards = []
        type = Card.column_for_attribute(key).type
        puts "#{key} is #{type.to_s}"
        if type.to_s == "string"
          clean_term =  value.upcase.gsub(/[^\x00-\x7F]/, ' ')
          for card in @cards
            clean_target = card[key].upcase.gsub(/[^\x00-\x7F]/, ' ')
            if clean_target.include? clean_term
              new_cards.push(card)
            end
          end
        elsif type.to_s == "integer"
          for card in @cards
            if card[key] == value.to_i
              new_cards.push(card)
            end
          end
        end
        @cards = new_cards
      end
    end
    render :index
  end

  def show
    @card = Card.find(params[:card_id])
    render :show
  end
  
end
