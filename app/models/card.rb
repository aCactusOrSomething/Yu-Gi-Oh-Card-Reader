# == Schema Information
#
# Table name: cards
#
#  atk            :integer
#  card_attribute :string
#  card_type      :string           not null
#  def            :integer
#  desc           :string           not null
#  frameType      :string           not null
#  level          :integer
#  linkmarkers    :string
#  linkval        :integer
#  name           :string           not null
#  race           :string
#  scale          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  card_id        :integer          not null, primary key
#
class Card < ApplicationRecord
  self.primary_key = :card_id

  # card_type helper functions. since card_type is a conglomeration of multiple card types, these check to see if an individual card type applies.
  # they're fairly simple, but they make my code further down the line prettier!


  def monster?
    card_type.include? "Monster"
  end

  # i break convention on Effect and Normal cards, because i think they'd be more confusing otherwise.
  # strictly speaking, all "Effect" type cards are monsters, but spells and traps still have effects...
  # and normal spells/ normal traps exist also, and those mean completely different things and aren't defined as types.
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
