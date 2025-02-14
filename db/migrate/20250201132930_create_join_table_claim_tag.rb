# frozen_string_literal: true

class CreateJoinTableClaimTag < ActiveRecord::Migration[7.1]
  def change
    create_join_table :claims, :tags do |t|
      t.index %i[claim_id tag_id]
      t.index %i[tag_id claim_id]
    end
  end
end
