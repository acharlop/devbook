class SiteController < ApplicationController
	def index
		@lang = Language.all.sample
		@classes = @lang.klasses
		@class = @classes.sample
		@methods = @class.meths
		@meth = @methods.sample
			puts "+" * 50
		p @meth
			puts "+" * 50
		unless @meth
			puts "+" * 50
			puts "methods:"
			puts @methods 
			puts "class:"
			puts @class
			puts "+" * 50
		end
	end
end
