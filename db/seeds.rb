# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

FAKE_CARD = Card.create!(
  card_id: -1,
  name: "No Card Found",
  card_type: "XYZ Monster",
  frameType: "xyz",
  desc: "Please type the card's full name.",
  atk: 200,
  def: 500,
  race: "Plant",
  card_attribute: "DIVINE" 
); # for testing purposes

require 'httparty'

puts 'pulling data from ygoprodeck...
'
response = HTTParty.get('https://db.ygoprodeck.com/api/v7/cardinfo.php').parsed_response

data = response['data']

puts 'converting data...'

data.each{ |card|
  card_id = 0
  name = ''
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

  ret = Card.create!(
    card_id: card_id,
    name: name,
    card_type: card_type,
    frameType: frameType,
    desc: desc,
    atk: c_atk,
    def: c_def,
    race: race,
    card_attribute: card_attribute,
    scale: scale,
    linkval: linkval,
    linkmarkers: linkmarkers,
    level: level
  )
}
puts 'migration complete.'