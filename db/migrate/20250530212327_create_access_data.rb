class CreateAccessData < ActiveRecord::Migration[7.1]
  def change
    create_table :access_data do |t|
      t.decimal :database_version

      t.timestamps
    end
  end
end
