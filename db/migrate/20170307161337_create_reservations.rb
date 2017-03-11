class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :domain
      t.boolean :available

      t.timestamps
    end
  end
end
