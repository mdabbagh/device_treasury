class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :tag
      t.string :category
      t.string :make
      t.string :model
      t.string :color
      t.integer :memory
      t.string :os
      t.string :features
      t.string :passcode
      t.boolean :available, null: false, default: true

      t.timestamps
    end
  end
end
