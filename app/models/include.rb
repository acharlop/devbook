class Include < ActiveRecord::Base
	belongs_to :includer, foreign_key: "includer_id", class_name: "Klass"
	belongs_to :includee, foreign_key: "includee_id", class_name: "Klass"
end
