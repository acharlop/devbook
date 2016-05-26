module RubyScraperHelper
	def clean_description page
		description = page.css("div.description > *")
		description = description.collect do |child|
			child.children.collect do |c| 
				case c.name
				when "pre"
					clean_ruby_code c
				when "a"
					clean_links c
				else
					clean_newlines c
				end
			end
		end
	end

	def clean_ruby_code code




	end


	def clean_links link
		href = link.attributes["href"].value
		href.downcase!
		href.gsub!(/\.html/,"")

		text = link.children[0].content
		text.gsub!(/\n/,"")

		link.attributes["href"].value = href
		link.children[0].content = text
		link
	end


	def clean_newlines text
		str = c.content
		str.gsub!(/\n/," ")
		text.content = str
		text
	end
end