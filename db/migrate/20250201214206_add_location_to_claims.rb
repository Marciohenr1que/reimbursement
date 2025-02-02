class AddLocationToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :location, :string, if_not_exists: true
  end
end
