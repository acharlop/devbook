class Klass < ActiveRecord::Base
	# language of class
	belongs_to :language

	# inherited classes
	belongs_to :parent, class_name: "Klass"
  has_many :children, class_name: "Klass", foreign_key: :parent_id

  # module can be included in many other classes & modules
  # ie. enumerable
	has_many :includer_module, foreign_key: :includee_id, class_name: "Include"
  has_many :includers, through: :includer_module, source: :includer

	has_many :includee_module, foreign_key: :includer_id, class_name: "Include"
  has_many :includees, through: :includee_module, source: :includee

# one class can have many classes / modules under it's namespace
	belongs_to :namespace, class_name: "Klass"
	has_many :namespaced_under, class_name: "Klass", foreign_key: :namespace_id

# Klass methods
	has_many :meths

# articles
	has_many :articles, as: :components

end
