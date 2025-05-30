# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'httparty'

# my internal database is seeded by copying an external reference database, specifically the one maintained by ygoprodeck.
# https://ygoprodeck.com/api-guide/ is their official guide page for this.
# the alternative would be to have no database of our own, and instead make API requests for one card every time the user loads a page...
# but the guide advises against doing this specifically, and instead recommends storing all data locally once pulled.

puts 'pulling data from ygoprodeck...'

response = HTTParty.get('https://db.ygoprodeck.com/api/v7/cardinfo.php').parsed_response

data = response['data']

puts 'converting data...'

# we want to take each card_dom from the external database, and copy (or update) the corresponding card_sub in our database. 
data.each{ |card_dom|
  card_id = 0
  
  if(card_dom.key?('id'))
    card_id = card_dom['id']
  end

  ret = Card.find_or_create_by(card_id: card_id) do |card_sub|

    # card_id
    card_sub.card_id = card_id

    # name and the derived name_searchable
    if(card_dom.key?('name'))
      card_sub.name = card_dom['name']
      
      #this regex replaces a bunch of characters that can't easily be typed with a " ".
      name_searchable = card_dom['name'].upcase.gsub!(/[^\x00-\x7F]/, ' ')
      if name_searchable != nil
        card_sub.name_searchable = name_searchable
      else # cards that need no substitutions just need to be shifted into uppercase
        card_sub.name_searchable = card_dom['name'].upcase
      end
    else
      card_sub.name = ''
      card_sub.name_searchable = ''
    end
    
    # card_type
    if(card_dom.key?('humanReadableCardType'))
      card_sub.card_type = card_dom['humanReadableCardType']
    else
      card_sub.card_type = ''
    end

    # frameType
    if(card_dom.key?('frameType'))
      card_sub.frameType = card_dom['frameType']
    else
      card_sub.frameType = ''
    end

    # desc (description)
    if(card_dom.key?('desc'))
      card_sub.desc = card_dom['desc']
    else
      card_sub.desc = ''
    end

    # c_atk (attack points)
    if(card_dom.key?('atk'))
      card_sub.c_atk = card_dom['atk']
    else
      card_sub.c_atk = 0
    end

    # c_def (defense points)
    if(card_dom.key?('def'))
      card_sub.c_def = card_dom['def']
    else
      card_sub.c_def = 0
    end

    # race
    if(card_dom.key?('race'))
      card_sub.race = card_dom['race']
    else
      card_sub.race = ''
    end
    
    # card_attribute
    if(card_dom.key?('attribute'))
      card_sub.card_attribute = card_dom['attribute']
    else
      card_sub.card_attribute = ''
    end

    # scale
    if(card_dom.key?('scale'))
      card_sub.scale = card_dom['scale']
    else
      card_sub.scale = 0
    end

    # linkval
    if(card_dom.key?('linkval'))
      card_sub.linkval = card_dom['linkval']
    else
      card_sub.linkval = 0
    end

    # linkmarkers
    if(card_dom.key?('linkmarkers'))
      card_sub.linkmarkers = card_dom['linkmarkers']
    else
      card_sub.linkmarkers = ''
    end

    # level
    if(card_dom.key?('level'))
      card_sub.level = card_dom['level']
    else
      card_sub.level = 0
    end
  end
}
puts 'migration complete.'