class Language < ActiveRecord::Base
	has_many :klasses
	has_many :documents

	def self.by_id id
		self.find_by(id: id)
	end

	# def as_jason(options={})
	# 	super(only: [:id,:name,:version,:url])
	# end
end