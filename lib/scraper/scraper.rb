require "nokogiri"
require "open-uri"
require "net/http"
require 'pry'

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
			# page.gsub!(/<!--(.*?)-->/,"")
			page
		end

		def clean_space str
			str.gsub(/\s+/," ").strip
		end

		class RubyScraper < Scraper
			attr_reader :language

			def initialize(base_uri)
				@base_uri = base_uri
				@language = {}
				@page = false
				load_details
			end

			def load_details
				return unless valid_url? @base_uri 
				page_string = get_fixed_page(@base_uri)
				@page = Nokogiri::HTML(page_string)
				language_details
				class_details
			end

			private

			# validate url exists, get index page, get details about version, get classes list
			def language_details
				header = @page.css("header h1").inner_text.split(" ")
				@language[:name] = header[0]
				@language[:version] = header[1]
			end

			def class_details
				@language[:classes] = @page.css("div#class-index .entries p a").collect{|c| {name: c.inner_text.strip} }
				@language[:classes].each_with_index do |k, i|
					url = "#{@base_uri}#{k[:name].gsub(/::/,"/")}.html"
					next unless valid_url? url
					k[:url] = url

					page_string = get_fixed_page(url)
					class_page = Nokogiri::HTML(page_string)
					# k[:descriptions] = scrape_class_description class_page
					k[:methods] = scrape_class_methods class_page

					puts (i + 1).to_s << "/" << @language[:classes].length.to_s << " completed"
					break
				end
			end



			def scrape_class_description class_page
				return_descs = []
				descriptions = class_page.css("div#description").children.reject {|c| c.class == Nokogiri::XML::Text}
				descriptions.each do |d|
					return_descs.push( process_elements(d) )
				end
				# Pry::ColorPrinter.pp(return_descs)
				return_descs
			end

			def scrape_class_methods class_page
				return_meths = []
				# types and signatures from dom
				method_types = class_page.css("div.method-section")
				signatures = class_page.css("div#method-list-section .link-list li").collect{|s| s.inner_text.gsub(/\s+/," ").strip}
				# class and instance methods
				method_types.each do |meths_type|
					type = meths_type.css("h3.section-header").inner_text.split(" ")[1].downcase
					meths = meths_type.css("div.method-detail")

					meths.each do |meth|
						meh = {type: type, name: signatures.shift, descriptions: [], examples: []}
						# get headings
						meh[:signatures] = meth.css("div.method-heading").collect do |h| 
							h.css("span.method-click-advice").remove
							h.inner_text.gsub(/\s+/," ").strip
						end
						# aliases in headings for now
						aliases = meth.css("div.aliases").inner_text.gsub(/\s+/," ").strip
						meh[:signatures].push aliases unless aliases.empty?

						# get source
						 source = meth.css("div.method-source-code").inner_html.gsub(/ +/," ").strip
						 meh[:source] = source

						# get descriptions, remove divs
						details = meth.last_element_child
						details.css("div").each{|d| d.remove}

						# get examples and descriptions
						details.children.each do |deet|
							element = process_elements deet
							next unless element
							if element =~ /<\/pre>\z/ 
								meh[:examples].push element
							else
								meh[:descriptions].push element
							end
						end

						return_meths.push(meh)
					end
				end
				return_meths
			end



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
		end
end

rby = Scraper::RubyScraper.new("http://ruby-doc.org/core-2.3.1/")
Pry::ColorPrinter.pp(rby.language[:classes][0])