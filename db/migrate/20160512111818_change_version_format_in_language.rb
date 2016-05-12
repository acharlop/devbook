class ChangeVersionFormatInLanguage < ActiveRecord::Migration
  def change
  	change_column :languages, :version, :string
  end
end
