class ChangeDefaultVersionFkToNullify < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :folders, column: :default_version_id
    add_foreign_key :folders, :versions, column: :default_version_id, on_delete: :nullify
  end
end
