class Language < ActiveRecord::Base
	has_many :klasses
	has_many :documents
end
