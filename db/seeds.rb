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

version_url = 'https://db.ygoprodeck.com/api/v7/checkDBVer.php'
cardinfo_url = 'https://db.ygoprodeck.com/api/v7/cardinfo.php'

#first, we should get the database version.
puts 'checking ygoprodeck database version...'
version_res = HTTParty.get(version_url).parsed_response
version_dom = version_res[0]['database_version']

puts "version: " + version_dom

# we need to compare the big db's version to our own cache of it
if AccessDatum.all[0] != nil and AccessDatum.all[0].database_version >= version_dom.to_d
  puts "local DB is up to date. no update necessary."
  return
end

puts "update needed."

#once we know that we're OK to get the big thing, we just do an API request for Everything...
puts 'pulling data from ygoprodeck...'
response = HTTParty.get(cardinfo_url).parsed_response
data = response['data']


puts 'Data recieved. Seeding local database...'
# this is for tracking progress.
i = 0
print i.to_s + "/" + data.length().to_s + "\s"
STDOUT.flush

# we want to take each card_dom from the external database, and copy (or update) the corresponding card_sub in our database. 
data.each{ |card_dom|
  card_id = 0
  
  if(card_dom.key?('id'))
    card_id = card_dom['id']
  end

  card_sub = Card.find_or_initialize_by(card_id: card_id)

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

  # atk (attack points)
  if(card_dom.key?('atk'))
    card_sub.atk = card_dom['atk']
  else
    card_sub.atk = 0
  end

  # def (defense points)
  if(card_dom.key?('def'))
    card_sub.def = card_dom['def']
  else
    card_sub.def = 0
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

  # art url
  if(card_dom.key?('card_images'))
    card_sub.art_url = card_dom['card_images'][0]['image_url_cropped']
  else
    card_sub.art_url = 'https://images.ygoprodeck.com/images/cards_cropped/' + card_sub.card_id + '.jpg'
  end
  
  card_sub.save!

  i = i + 1
  print "\r"
  print i.to_s + "/" + data.length().to_s + "\s"
  STDOUT.flush
}
print "\nall data converted.\n"

# now we need to update the AccessDatum with the current version.
AccessDatum.find_or_create_by(id: 0) do |access_datum|
  access_datum.database_version = version_dom.to_d
end
puts 'Seeding complete! updated'