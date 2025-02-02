class CreateClaimTags < ActiveRecord::Migration[7.1]
  def change
    create_table :claim_tags do |t|
      t.references :claim, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
