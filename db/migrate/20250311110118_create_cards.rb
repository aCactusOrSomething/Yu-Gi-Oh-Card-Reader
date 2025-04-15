class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards, id: false, primary_key: :card_id do |t|
      t.integer :card_id, null: false
      t.string :name, null: false
      t.string :card_type, null: false
      t.string :frameType, null: false
      t.string :desc, null: false
      t.integer :atk
      t.integer :def
      t.string :race
      t.string :card_attribute
      t.integer :scale
      t.integer :linkval
      t.string :linkmarkers
      t.integer :level

      t.timestamps
    end
  end
end
