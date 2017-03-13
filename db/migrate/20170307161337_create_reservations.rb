class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :name , null: false
      t.string :domain, null: false
      t.integer :classification, null: false
      t.boolean :available, default: false

      t.timestamps
    end
  end
end
