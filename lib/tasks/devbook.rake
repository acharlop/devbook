namespace :devbook do
  desc "Run scrape scripts and build database"
  task scrape: :environment do
  end

  desc "Unloads and then scrapes"
  task rebuild: :environment do
  	Rake::Task["db:schema:load"].execute
  end

end
