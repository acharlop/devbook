class Klass < ActiveRecord::Base
	# language of class
	belongs_to :language

	# inherits class
	has_one :parent, class_name: "Klass", foreign_key: :parent_id
  belongs_to :inherits, class_name: "Klass", foreign_key: :parent_id

  # 
	# has_many :includes, class_name: "Klass", foreign_key: "uses_id"
 #  belongs_to :uses, class_name: "Klass"

	#
	# has_many :children, class_name: "Klass", foreign_key: "parent_id"
 #  belongs_to :parent, class_name: "Klass"

end
