class CreateJoinTableClaimTag < ActiveRecord::Migration[7.1]
  def change
    create_join_table :claims, :tags do |t|
      t.index [:claim_id, :tag_id]
      t.index [:tag_id, :claim_id]
    end
  end
end
