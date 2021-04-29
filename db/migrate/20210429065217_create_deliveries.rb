class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string     :postcode,       null: false
      t.integer    :prefecture_id,  null: false
      t.string     :city,           null: false
      t.string     :block,          null: false
      t.string     :building
      t.string     :tel,            null: false
      t.references :order,          foreign_key: true
      t.timestamps
    end
  end
end
