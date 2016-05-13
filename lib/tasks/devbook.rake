namespace :devbook do
  desc "Run scrape scripts and build database"
  task scrape: :environment do
  	rby = RubyScraper.new
  	Loader.new rby.language
  end

  desc "Rebuild database"
  task :reload => ["db:drop","db:create","db:migrate"] 
  # not "db:schema:load"]

  desc "Heroku rebuild database"
  task :heroku_reload :environment do 
  	heroku pg:reset DATABASE --confirm doc-page
  end

  desc "Rebuild db then scrape on heroku"
  task :heroku ["devbook:heroku_reload","devbook:scrape"]

  task :all => ["devbook:reload","devbook:scrape"]
end

desc "Rebuild db then scrape"
task :devbook => ["devbook:all"] 
