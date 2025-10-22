# == Schema Information
#
# Table name: cards
#
#  id              :bigint           not null
#  atk             :integer
#  card_attribute  :string
#  card_type       :string
#  def             :integer
#  desc            :string
#  frameType       :string
#  level           :integer
#  linkmarkers     :string
#  linkval         :integer
#  name            :string
#  name_searchable :string
#  race            :string
#  scale           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  card_id         :integer          primary key
#
# Indexes
#
#  index_cards_on_card_id  (card_id) UNIQUE
#
class Card < ApplicationRecord
  self.primary_key = :card_id

  # TODO: is there a way to make this data generate automatically when seeding?
  # that way, I won't have to update it manually if the game changes.

  # all possible card types
  CARD_TYPES = [
    "token",
    "monster",
    "normal",
    "effect",
    "fusion",
    "ritual",
    "synchro",
    "xyz",
    "link",
    "pendulum",

    "union",
    "flip",
    "spirit",
    "gemini",
    "toon",
    "tuner",

    "spell",
    "quick-play",
    "continuous",
    "field",

    "trap",
    "counter",
  ]

  # all possible monster attributes
  CARD_ATTRIBUTES = [
    "LIGHT",
    "DARK",
    "EARTH",
    "FIRE",
    "WATER",
    "WIND",
    "DIVINE"
  ]

  # all possible monster tribes
  CARD_RACE = [
    "beast-warrior",
    "zombie",
    "fiend",
    "dinosaur",
    "dragon",
    "beast",
    "illusion",
    "insect",
    "winged beast",
    "warrior",
    "sea serpent",
    "machine",
    "aqua",
    "pyro",
    "thunder",
    "spellcaster",
    "plant",
    "rock",
    "reptile",
    "fairy",
    "fish",
    "divine-beast",
    "psychic",
    "creator god",
    "wyrm",
    "cyberse"
  ]

  # card_type helper functions. since card_type is a conglomeration of multiple card types, these check to see if an individual card type applies.
  # they're fairly simple, but they make my code further down the line prettier!
  def monster?
    card_type.include? "Monster"
  end

  def effect_monster?
    card_type.include? "Effect"
  end

  def normal_monster?
    card_type.include? "Normal"
  end

  def flip?
    card_type.include? "Flip"
  end

  def tuner?
    card_type.include? "Tuner"
  end

  def gemini?
    card_type.include? "Gemini"
  end

  def pendulum?
    card_type.include? "Pendulum"
  end

  def ritual?
    card_type.include? "Ritual"
  end

  def spirit?
    card_type.include? "Spirit"
  end

  def toon?
    card_type.include? "Toon"
  end

  def union?
    card_type.include? "Union"
  end

  def spell?
    card_type.include? "Spell"
  end

  def trap?
    card_type.include? "Trap"
  end

  def link_marker_as_string
    linkmarkers.tr('"[]', '')
  end

  def link_marker_as_array
    link_marker_as_string.tr(' ', '').split(',')
  end
  
end
