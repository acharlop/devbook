class AddLangAssocesToKlass < ActiveRecord::Migration
  def change
    add_reference :klasses, :language, index: true, foreign_key: true
  end
end
