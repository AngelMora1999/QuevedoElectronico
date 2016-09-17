# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  name                   :string           default(""), not null
#  uid                    :string
#  provider               :string
#  permission_level       :integer          default(1)
#  status                 :string
#  balance                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :ads

  include PermissionsConcern
  include AASM

  #Maquina de estado para los usuarios
  aasm column: "status" do
    state :actived, initial: true
    state :locked

    event :lock do
      transitions from: :actived, to: :locked
    end

    event :active do
      transitions from: :locked, to: :actived
    end
  end

  #Scopes for the users
  scope :facebook, ->{ where(provider:"facebook") }

  #Funcion para verificar si !existe el usuario login con facebook => crea un usuario
  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid] ).first_or_create do |user|
      if auth[:info]
        user.email = auth[:info][:email]
        user.name = auth[:info][:name]
        user.provider = auth[:provider]
        user.uid = auth[:uid]
      end
      user.password = Devise.friendly_token[0,20]
    end
  end
end
