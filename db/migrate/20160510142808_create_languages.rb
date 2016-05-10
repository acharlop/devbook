class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.decimal :version

      t.timestamps null: false
    end
  end
end
