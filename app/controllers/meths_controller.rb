class MethsController < ApplicationController
	def index
		klass = Klass.by_id params[:klass_id]
		@meths = klass ? klass.meths : {error: "No methods found"}
		render json: @meths
	end
	def show
		@meth = Meth.by_id params[:id]
		render json: @meth
	end
end
