class Article < ActiveRecord::Base
  belongs_to :module

  def self.by_id id
		self.find_by(id: id)
	end
end
