class AddDefaultVersionToFolders < ActiveRecord::Migration[7.1]
  def change
    add_reference :folders, :default_version, foreign_key: { to_table: :versions }
  end
end
