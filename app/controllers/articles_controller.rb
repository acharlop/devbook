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
		klass = Klass.by_id params[:klass_id]
		puts klass[:id]
		if klass
			article_array = klass.articles.reverse
			article_array = article_array.collect {|a| a.text}
			@articles = []
			article_array.each do |a|
				if a =~ /\A<h2/
					@articles << {title: a,text: ""}
				else
					@articles.last[:text] << a
				end
			end

		else
			@articles = [{title: "<h2>No description for this class</h2>", text:"<p></p>"}]
		end


		# render  "class_components"
	end
end
