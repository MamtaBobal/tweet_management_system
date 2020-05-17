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

  #Validations
  validates :tweet, presence: true

  def is_owner(user_id)
    self.user_id == user_id
  end
end
