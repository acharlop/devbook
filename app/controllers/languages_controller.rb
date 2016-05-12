class LanguagesController < ApplicationController
	def index
		@languages = Language.all
		render json: @languages
	end
	def show
		@language = Language.by_id params[:id]
		render json: @language
	end

end
