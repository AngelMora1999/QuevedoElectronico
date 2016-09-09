class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.string :brand
      t.integer :price
      t.string :state
      t.integer :visit_count
      t.string :region, default: "Los Riós"
      t.string :city, default: "Quevedo"
      t.string :cellphone
      t.string :phone
      t.string :adress
      t.string :status
      t.attachment :cover
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
