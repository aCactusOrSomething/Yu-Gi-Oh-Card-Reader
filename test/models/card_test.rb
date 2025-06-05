# frozen_string_literal: true

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
require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
