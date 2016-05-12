class SiteController < ApplicationController
	def index
		@lang = Language.all.sample
		@classes = @lang.klasses
		@class = @classes.sample
		@methods = @class.meths
		@meth = @methods.sample
	end
end
