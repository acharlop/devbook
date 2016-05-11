class CreateIncludes < ActiveRecord::Migration
  def change
    create_table :includes do |t|
      t.integer :includer_id
      t.integer :includee_id

      t.timestamps null: false
    end
  end
end
