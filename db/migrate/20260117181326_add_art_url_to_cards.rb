class AddArtUrlToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :art_url, :string
  end
end
