# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  brand       :string
#  price       :integer
#  state       :string
#  visit_count :integer
#  region      :string           default("Los Riós")
#  city        :string           default("Quevedo")
#  cellphone   :string
#  phone       :string
#  adress      :string
#  status      :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ad < ApplicationRecord
  belongs_to :user

  include AASM

  #Maquina de estados para las ad
  aasm column: "status" do
  	state :published, initial: true
  	state :toped
  	state :premiuned
  	state :selled

  	event :top do
      after do
        user.lock!
      end
  		transitions from: :published, to: :toped
  	end

  	event :premiun do
      after do
        user.lock!
      end
  		transitions from: :published, to: :premiuned
  	end

  	event :down do
      after do
        user.active!
      end
  		transitions from: [:toped, :premiuned], to: :published
  	end

  	event :sell do
  		transitions from: [:published, :toped, :premiuned], to: :selled
  	end
  end
end
