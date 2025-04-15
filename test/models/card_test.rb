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
require "test_helper"

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
