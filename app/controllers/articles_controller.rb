class ArticlesController < ApplicationController
	respond_to :json, :js

	def index
		klass = Klass.by_id params[:klass_id]
		@articles = klass ? klass.articles.reverse : {error: "Error class has no articles"}
		render json: @articles	
	end
	def show
		@article = Article.by_id params[:id]
		render json: @article
	end

	def ajax_index
		@articles = Article.by_klass_id params[:klass_id]
	end
end
