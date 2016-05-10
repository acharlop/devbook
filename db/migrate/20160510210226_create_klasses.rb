class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.string :name
      t.text :definition
      t.boolean :module

      t.timestamps null: false
    end
  end
end
