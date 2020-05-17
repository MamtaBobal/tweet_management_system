# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  is_admin               :boolean
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  organization_id        :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :tweeets
  belongs_to :organization

  def generate_password_token
    self.update(reset_password_token: generate_token, reset_password_sent_at: Time.now.utc)
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.update(reset_password_token: nil, password: password)
  end

  def generate_jwt
    JWT.encode({ id: id,
              exp: 60.days.from_now.to_i },
             Rails.application.secrets.secret_key_base)
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end

end
