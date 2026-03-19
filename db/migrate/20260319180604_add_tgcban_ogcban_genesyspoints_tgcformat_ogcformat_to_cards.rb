class AddTgcbanOgcbanGenesyspointsTgcformatOgcformatToCards < ActiveRecord::Migration[8.1]
  def change
    add_column :cards, :tcg_ban, :string
    add_column :cards, :ocg_ban, :string
    add_column :cards, :genesys_points, :integer
    add_column :cards, :tcg_format, :boolean
    add_column :cards, :ocg_format, :boolean
  end
end
