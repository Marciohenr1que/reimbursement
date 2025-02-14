# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    return if column_exists?(:users, :role)

    add_column :users, :role, :integer
  end
end
