class CreateMeths < ActiveRecord::Migration
  def change
    create_table :meths do |t|
      t.string :name
      t.string :signature
      t.text :description
      t.text :example
      t.text :source
      t.boolean :class_method

      t.timestamps null: false
    end
  end
end
