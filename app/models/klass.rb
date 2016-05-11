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


 # # follower_follows "names" the Follow join table for accessing through the follower association
 #  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow" 
 #  # source: :follower matches with the belong_to :follower identification in the Follow model 
 #  has_many :followers, through: :follower_follows, source: :follower

 #  # followee_follows "names" the Follow join table for accessing through the followee association
 #  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"    
 #  # source: :followee matches with the belong_to :followee identification in the Follow model   
 #  has_many :followees, through: :followee_follows, source: :followee




	#
	# has_many :children, class_name: "Klass", foreign_key: "parent_id"
 #  belongs_to :parent, class_name: "Klass"

end
