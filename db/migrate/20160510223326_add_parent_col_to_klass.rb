class AddParentColToKlass < ActiveRecord::Migration
  def change
    add_column :klasses, :parent_id, :integer
  end
end
