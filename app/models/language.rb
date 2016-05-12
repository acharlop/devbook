class Language < ActiveRecord::Base
	has_many :klasses
	has_many :documents

	def self.by_id id
		self.find_by(id: id)
	end
end
