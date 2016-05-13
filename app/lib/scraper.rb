require "nokogiri"
require "open-uri"
require "net/http"

# TODO
# Separate files
# add parents
# add attributes back in
# cleanup input as text

class Scraper
		def valid_url? test_url
			url = URI.parse(test_url)
			req = Net::HTTP.new(url.host, url.port)
			res = req.request_head(url.path)
			res.code.to_i == 200
		end

		def get_fixed_page url
			page = open(url) {|io| data = io.read}
			page.gsub!(/<</,"&lt;&lt;")
			page.gsub!(/<=>/,"&lt;=&gt;")
			page.gsub!(/ +/," ")
			page.gsub!(/ +\n+|\n+ +/,"\n")
			# page.gsub!(/<!--(.*?)-->/,"")
			page
		end

		# main process
		def process_elements e
			if e.class == Nokogiri::XML::Text
				return if e.inner_text =~ /\A\s*\z/
			else
				links = e.search("a") # removing links for now until logic is completed
				links.each{|l| l.replace(l.content)}
				if e.name == "p"
					e.to_html.gsub(/\s+/," ").strip
				elsif e.name =~ /\Ah/ 
					e.css("span").remove
					e["class"] = "klass-description-title"
					e.delete "id"
					e.to_html.gsub(/\s+/," ").strip
				elsif e.name == "pre"
					e.to_html.gsub(/ruby-/,"").gsub(/\s+/," ").strip
				end
			end
		end

		def clean_space str
			str.gsub(/\s+/," ").strip
		end
end