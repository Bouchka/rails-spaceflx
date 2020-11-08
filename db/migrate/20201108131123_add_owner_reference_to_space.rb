class AddOwnerReferenceToSpace < ActiveRecord::Migration[6.0]
  def change
    add_reference :spaces, :owner_id, null: false, foreign_key: {to_table: :users}
  end
end
