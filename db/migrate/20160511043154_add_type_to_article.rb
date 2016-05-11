class AddTypeToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :components_type, :string
  end
end
