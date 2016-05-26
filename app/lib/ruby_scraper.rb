class RubyScraper < Scraper
	include RubyScraperHelper
		attr_reader :language

		def initialize(base_uri = "http://ruby-doc.org/core-2.3.1/")
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
			@language[:url] = @base_uri
		end

		def class_details
			@language[:classes] = @page.css("div#class-index .entries p a").collect{|c| {name: c.inner_text.strip} }
			@language[:classes].each_with_index do |k, i|
				url = "#{@base_uri}#{k[:name].gsub(/::/,"/")}.html"
				next unless valid_url? url
				k[:url] = url

				page_string = get_fixed_page(url)
				class_page = Nokogiri::HTML(page_string)
				k[:articles] = scrape_class_articles class_page
				k[:articles].unshift "<h4 class=\"klass-description-title\">" << k[:name] << "</h4>"
				k[:methods] = scrape_class_methods class_page

				puts (i + 1).to_s << "/" << @language[:classes].length.to_s << " - " << k[:name]
			end
		end



		def scrape_class_articles class_page
			return_descs = []
			articles = class_page.css("div#description").children.reject {|c| c.class == Nokogiri::XML::Text}
			articles.each do |d|
				return_descs << process_elements(d)
			end
			# Pry::ColorPrinter.pp(return_descs)
			return_descs
		end

		def scrape_class_methods class_page
	# removing attributes for now
			class_page.css("div#attribute-method-details").remove
	#
			return_meths = []

			# types and signatures from dom
			method_types = class_page.css("div.method-section")
			signatures = class_page.css("div#method-list-section .link-list li").collect{|s| s.inner_text.gsub(/\s+/," ").strip}
			# class and instance methods
			method_types.each do |meths_type|
				type = meths_type.css("h3.section-header").inner_text.split(" ")[1].downcase
				meths = meths_type.css("div.method-detail")

				meths.each do |meth|
					meh = {type: type, name: signatures.shift, articles: [], examples: []}
					# get headings
					meh[:signatures] = meth.css("div.method-heading").collect do |h| 
						h.css("span.method-click-advice").remove
						h.inner_text.gsub(/ +/," ").strip
						# h.children.collect{|t|t.name = "h3"}
						# h.children
					end
					# aliases in headings for now
					aliases = meth.css("div.aliases").inner_text.gsub(/\s+/," ").strip
					meh[:signatures] << aliases unless aliases.empty?

					# get source
					 source = meth.css("div.method-source-code").inner_html.gsub(/ +/," ").strip
					 meh[:source] = source

					# get articles, remove divs
					details = meth.last_element_child
					details.css("div").each{|d| d.remove}

					# get examples and articles
					details.children.each do |deet|
						element = process_elements deet
						next unless element
						if element =~ /<\/pre>\z/ 
							meh[:examples] << element
						else
							meh[:articles] << element
						end
					end

					return_meths << meh
				end
			end



			return_meths
		end


end