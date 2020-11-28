class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string  :product,           null: false
      t.text    :description,       null: false
      t.integer :category_id ,      null: false
      t.integer :condition_id,      null: false
<<<<<<< Updated upstream
      t.integer :nprice,            null: false
=======
      t.integer :price,             null: false
>>>>>>> Stashed changes
      t.integer :deliveryfee_id ,   null: false
      t.integer :area_id,           null: false
      t.integer :shipping_id,       null: false
      t.references :user,           foreign_key: true 
      t.timestamps
    end
  end
end
