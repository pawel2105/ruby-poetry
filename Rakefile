desc "This task collects new headlines"
task :collect do
 ruby 'get_headlines.rb'
 ruby 'find.rb'
 ruby 'write_page.rb'
end

desc "This task publishes headlines"
task :publish do
 ruby 'tweet_n_delete.rb'
end