class AddAddressToSpaces < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :address, :string
  end
end
