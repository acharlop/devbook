namespace :devbook do
  desc "Run scrape scripts and build database"
  task scrape: :environment do
  	rby = RubyScraper.new
  	Loader.new rby.language
  end

  desc "Rebuild database"
  task :reload => ["db:drop","db:create","db:migrate"] 
  # not "db:schema:load"]

  task :all => ["devbook:reload","devbook:scrape"]
end

desc "Rebuild db then scrape"
task :devbook => ["devbook:all"] 
