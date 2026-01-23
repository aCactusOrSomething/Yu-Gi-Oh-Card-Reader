class CardsController < ApplicationController
  def index
    @cards = Card.all
    @term = params[:name_searchable]

    params.each do |key, value|
      unless !value.nil? and key != 'commit' and key != 'controller' and key != 'action' and value != 0 and value != ''
        next
      end

      new_cards = []
      type = Card.column_for_attribute(key).type
      puts "#{key} is #{type}"
      if type.to_s == 'string'
        clean_term =  value.upcase.gsub(/[^\x00-\x7F]/, ' ')
        for card in @cards
          clean_target = card[key].upcase.gsub(/[^\x00-\x7F]/, ' ')
          new_cards.push(card) if clean_target.include? clean_term
        end
      elsif type.to_s == 'integer'
        for card in @cards
          new_cards.push(card) if card[key] == value.to_i
        end
      end
      @cards = new_cards
    end
    render :index
  end

  def show
    @card = Card.find(params[:card_id])
    # check to see if the card has an image
    unless @card.art.attached?
      # if not, attempt to download the image
      @card.attach_file(@card.art_url, :art, @card.card_id.to_s)
    end
    # render should go through EVEN IF the image download fails
    render :show
  end
end
