class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.integer :tid
      t.string :thing
      t.string :content

      t.timestamps
    end
  end
end
