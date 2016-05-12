class Meth < ActiveRecord::Base
	belongs_to :klass

	def self.by_id id
		self.find_by(id: id)
	end
end
