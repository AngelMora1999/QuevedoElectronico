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
  before_save :set_visit_count
  has_attached_file :cover, styles: { medium: "400*400", thumb: "200*200" }, default_url: "http://fravega.vteximg.com.br/arquivos/ids/275446-1000-1000/CELULAR-LIBRE-SAMSUNG-GRAND-PRIME-WHITE-4G.jpg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

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

  #Scopes for the ads
  scope :premiuns, ->{ where(status:"premiuned") }

  scope :tops, ->{ where(status:"toped") }

  scope :selled, ->{ where(status:"selled") }

  scope :activo, ->{ where(status:["premiuned", "toped", "published"]) }

  scope :usados, ->{ where(state:"Usado") }

  scope :nuevos, ->{ where(state:"Nuevo") }

  scope :economicos, ->{ order("price") }

  scope :caros, ->{ order("price DESC") }

  scope :populares, ->{ order("visit_count DESC") }
  
  scope :ultimos, ->{ order("created_at DESC") }

  def update_visit_count
    self.update(visit_count: self.visit_count + 1)
  end

  private
  def set_visit_count
    self.visit_count ||= 0
  end
end
