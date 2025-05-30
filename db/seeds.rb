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

puts 'pulling data from ygoprodeck...
'
response = HTTParty.get('https://db.ygoprodeck.com/api/v7/cardinfo.php').parsed_response

data = response['data']

puts 'converting data...'

data.each{ |card|
  card_id = 0
  name = ''
  name_searchable = ''
  card_type = ''
  frameType = ''
  desc = ''
  c_atk = 0
  c_def = 0
  race = ''
  card_attribute = ''
  scale = 0
  linkval = 0
  linkmarkers = ''
  level = 0

  if(card.key?('id'))
    card_id = card['id']
  end
  if(card.key?('name'))
    name = card['name']
    name_searchable = name.upcase.gsub!(/[^\x00-\x7F]/, ' ')
    if name_searchable == nil
      name_searchable = name.upcase
    end
  end
  if(card.key?('humanReadableCardType'))
    card_type = card['humanReadableCardType']
  end
  if(card.key?('frameType'))
    frameType = card['frameType']
  end
  if(card.key?('desc'))
    desc = card['desc']
  end
  if(card.key?('atk'))
    c_atk = card['atk']
  end
  if(card.key?('def'))
    c_def = card['def']
  end
  if(card.key?('race'))
    race = card['race']
  end
  if(card.key?('attribute'))
    card_attribute = card['attribute']
  end
  if(card.key?('scale'))
    scale = card['scale']
  end
  if(card.key?('linkval'))
    linkval = card['linkval']
  end
  if(card.key?('linkmarkers'))
    linkmarkers = card['linkmarkers']
  end
  if(card.key?('level'))
    level = card['level']
  end

  # creates the card in the database
  # previously used create! which causes problems when updating existing databases.
  ret = Card.find_or_create_by(card_id: card_id) do |db_card|
    db_card.card_id = card_id
    db_card.name = name
    db_card.name_searchable = name_searchable
    db_card.card_type = card_type
    db_card.frameType = frameType
    db_card.desc = desc
    db_card.atk = c_atk
    db_card.def = c_def
    db_card.race = race
    db_card.card_attribute = card_attribute
    db_card.scale = scale
    db_card.linkval = linkval
    db_card.linkmarkers = linkmarkers
    db_card.level = level
  end
}
puts 'migration complete.'