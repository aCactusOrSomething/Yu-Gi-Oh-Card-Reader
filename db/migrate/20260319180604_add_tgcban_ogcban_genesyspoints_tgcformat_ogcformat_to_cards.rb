class AddTgcbanOgcbanGenesyspointsTgcformatOgcformatToCards < ActiveRecord::Migration[8.1]
  def change
    add_column :cards, :tgc_ban, :string
    add_column :cards, :ogc_ban, :string
    add_column :cards, :genesys_points, :integer
    add_column :cards, :tgc_format, :boolean
    add_column :cards, :ogc_format, :boolean
  end
end
