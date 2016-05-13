class Article < ActiveRecord::Base
  belongs_to :module

  def self.by_id id
		self.find_by(id: id)
	end

	def self.by_klass_id klass_id
		self.by_klass Klass.by_id(klass_id)
	end

	def self.by_klass klass
		raw = klass.articles.order(id: :asc)
		arr = raw.collect {|a| a.text}
		art = []
		arr.each do |a|
			if a !~ /\A<p/
				# temp fix
				a.gsub!(/h2/,"h4")
				# 
				art << {title: a, text: ""}
			else
				art.last[:text] << a
			end
		end
		
		art << {title: "<h4>No description for this class</h4>", text:"<p></p>"} if art.empty?
		
		art
	end
end
