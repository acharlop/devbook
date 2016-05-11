class AddKlassToMeth < ActiveRecord::Migration
  def change
    add_reference :meths, :klass, index: true, foreign_key: true
  end
end
