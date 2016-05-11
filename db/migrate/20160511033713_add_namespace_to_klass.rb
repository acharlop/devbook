class AddNamespaceToKlass < ActiveRecord::Migration
  def change
    add_column :klasses, :namespace_id, :integer
  end
end
