class FixSpaceReferences < ActiveRecord::Migration[6.0]
  def change
    remove_reference :spaces, :owner_id, index: true
    add_reference :spaces, :owner, null: false, foreign_key: {to_table: :users}
  end
end
