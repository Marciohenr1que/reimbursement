# frozen_string_literal: true

class CreateClaims < ActiveRecord::Migration[7.1]
  def change
    create_table :claims do |t|
      t.string :description
      t.decimal :amount
      t.date :date
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
