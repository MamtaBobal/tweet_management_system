# == Schema Information
#
# Table name: tweeets
#
#  id         :integer          not null, primary key
#  tweet      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Tweeet < ApplicationRecord

  #Associations
  belongs_to :user
end
