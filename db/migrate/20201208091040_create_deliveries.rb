class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :postcd,        null: false
      t.string :city,          null: false
      t.integer :area_id,      null: false
      t.string :addressb,      null: false
      t.string :building
      t.string :phone,         null: false
      t.references :purchase,  foreign_key: true
      t.timestamps
    end
  end
end
