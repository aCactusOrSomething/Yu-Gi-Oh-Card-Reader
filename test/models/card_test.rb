# == Schema Information
#
# Table name: cards
#
#  id              :integer          not null
#  card_id         :integer          primary key
#  name            :string
#  card_type       :string
#  frameType       :string
#  desc            :string
#  atk             :integer
#  def             :integer
#  race            :string
#  card_attribute  :string
#  scale           :integer
#  linkval         :integer
#  linkmarkers     :string
#  level           :integer
#  name_searchable :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  art_url         :string
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
