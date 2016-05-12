class Loader
	def initialize lang
		@lang = lang
		load_lang
		load_classes
		puts "Load completed"
		true
	end

	private

	def load_lang
		Language.create(
			name: @lang[:name], 
			version: @lang[:version],
			url: @lang[:url])
	end
	def load_classes
		@lang[:classes].each do |k|
			# create class
			klass = Klass.create(name: k[:name])
			# create articles
			k[:articles].each do |text|
				klass.articles.push Article.create(text: text)
			end
			# create methods
			k[:methods].each do |m|
				meth = load_method m
				klass.meths.push meth
			end
		end
	end
	
	def load_method meth
		Meth.create(
			name: meth[:name],
			signature: meth[:signatures].join(" "),
			description: meth[:articles].join(" "),
			example: meth[:examples].join(" "),
			source: meth[:source],
			class_method: meth[:type] == "class"	
		)
	end
end