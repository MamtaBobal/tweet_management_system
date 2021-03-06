# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ApplicationRecord

  #Associations
  has_many :users

  #Validations
  validates :name, uniqueness: true, presence: true
end
