class SiteController < ApplicationController
	def index
		@lang = Language.first
		@class = @lang.klasses.first
		@methods = @class.meths
		@meth = @methods.find_by(name: "#<=>")
	end
end
