class KlassesController < ApplicationController
	def index
		lang = Language.by_id params[:language_id]
		@klasses = lang ? lang.klasses : {error: "Error language has no classes"}
		render json: @klasses	
	end
	def show
		@klass = Klass.by_id params[:id]
		render json: @klass
	end
end
