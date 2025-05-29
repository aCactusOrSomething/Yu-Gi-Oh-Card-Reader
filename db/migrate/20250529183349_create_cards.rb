class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.integer :card_id
      t.string :name
      t.string :card_type
      t.string :frameType
      t.string :desc
      t.integer :atk
      t.integer :def
      t.string :race
      t.string :card_attribute
      t.integer :scale
      t.integer :linkval
      t.string :linkmarkers
      t.integer :level
      t.string :name_searchable

      t.timestamps
    end
  end
end
