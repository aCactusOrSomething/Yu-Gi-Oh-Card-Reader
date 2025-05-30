# == Schema Information
#
# Table name: access_data
#
#  id               :bigint           not null, primary key
#  database_version :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class AccessDatum < ApplicationRecord
end
