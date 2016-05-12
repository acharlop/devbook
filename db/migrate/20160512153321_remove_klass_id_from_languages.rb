class RemoveKlassIdFromLanguages < ActiveRecord::Migration
  def change
  	remove_column :languages, :klass_id, :string
  end
end
