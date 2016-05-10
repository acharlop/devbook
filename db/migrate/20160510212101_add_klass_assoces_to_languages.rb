class AddKlassAssocesToLanguages < ActiveRecord::Migration
  def change
    add_reference :languages, :klass, index: true, foreign_key: true
  end
end
