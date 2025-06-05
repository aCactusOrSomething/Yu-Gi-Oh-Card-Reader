# frozen_string_literal: true

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

# my internal database is seeded by copying an external reference database,
# specifically the one maintained by ygoprodeck.
# https://ygoprodeck.com/api-guide/ is their official guide page for this.
# the alternative would be to have no database of our own,
# and instead make API requests for one card every time the user loads a page...
# but the guide advises against doing this specifically, and instead recommends storing all data locally once pulled.

version_url = 'https://db.ygoprodeck.com/api/v7/checkDBVer.php'
cardinfo_url = 'https://db.ygoprodeck.com/api/v7/cardinfo.php'

# first, we should get the database version.
Rails.logger.debug 'checking ygoprodeck database version...'
version_res = HTTParty.get(version_url).parsed_response
version_dom = version_res[0]['database_version']

Rails.logger.debug { "version: #{version_dom}" }

# we need to compare the big db's version to our own cache of it
if !AccessDatum.all[0].nil? && (AccessDatum.all[0].database_version >= version_dom.to_d)
  Rails.logger.debug 'local DB is up to date. no update necessary.'
  return
end

Rails.logger.debug 'update needed.'

# once we know that we're OK to get the big thing, we just do an API request for Everything...
Rails.logger.debug 'pulling data from ygoprodeck...'
response = HTTParty.get(cardinfo_url).parsed_response
data = response['data']

Rails.logger.debug 'Data recieved. Seeding local database...'
# this is for tracking progress.
i = 0
Rails.logger.debug { "#{i}/#{data.length} " }
$stdout.flush

# we want to take each card_dom from the external database,
# and copy (or update) the corresponding card_sub in our database.
data.each do |card_dom|
  card_id = 0

  card_id = card_dom['id'] if card_dom.key?('id')

  Card.find_or_create_by(card_id: card_id) do |card_sub|
    # card_id
    card_sub.card_id = card_id

    # name and the derived name_searchable
    if card_dom.key?('name')
      card_sub.name = card_dom['name']

      # this regex replaces a bunch of characters that can't easily be typed with a " ".
      name_searchable = card_dom['name'].upcase.gsub!(/[^\x00-\x7F]/, ' ')
      # cards that need no substitutions just need to be shifted into uppercase
      card_sub.name_searchable = if name_searchable.nil?
                                   card_dom['name'].upcase
                                 else
                                   name_searchable
                                 end
    else
      card_sub.name = ''
      card_sub.name_searchable = ''
    end

    # card_type
    card_sub.card_type = if card_dom.key?('humanReadableCardType')
                           card_dom['humanReadableCardType']
                         else
                           ''
                         end

    # frameType
    card_sub.frameType = if card_dom.key?('frameType')
                           card_dom['frameType']
                         else
                           ''
                         end

    # desc (description)
    card_sub.desc = if card_dom.key?('desc')
                      card_dom['desc']
                    else
                      ''
                    end

    # atk (attack points)
    card_sub.atk = if card_dom.key?('atk')
                     card_dom['atk']
                   else
                     0
                   end

    # def (defense points)
    card_sub.def = if card_dom.key?('def')
                     card_dom['def']
                   else
                     0
                   end

    # race
    card_sub.race = if card_dom.key?('race')
                      card_dom['race']
                    else
                      ''
                    end

    # card_attribute
    card_sub.card_attribute = if card_dom.key?('attribute')
                                card_dom['attribute']
                              else
                                ''
                              end

    # scale
    card_sub.scale = if card_dom.key?('scale')
                       card_dom['scale']
                     else
                       0
                     end

    # linkval
    card_sub.linkval = if card_dom.key?('linkval')
                         card_dom['linkval']
                       else
                         0
                       end

    # linkmarkers
    card_sub.linkmarkers = if card_dom.key?('linkmarkers')
                             card_dom['linkmarkers']
                           else
                             ''
                           end

    # level
    card_sub.level = if card_dom.key?('level')
                       card_dom['level']
                     else
                       0
                     end
  end

  i += 1
  Rails.logger.debug "\r"
  Rails.logger.debug { "#{i}/#{data.length} " }
  $stdout.flush
end
Rails.logger.debug "\nall data converted.\n"

# now we need to update the AccessDatum with the current version.
AccessDatum.find_or_create_by(id: 0) do |access_datum|
  access_datum.database_version = version_dom.to_d
end
Rails.logger.debug 'Seeding complete!'
