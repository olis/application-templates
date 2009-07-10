load_template '/Users/olis/rails/application-templates/base.rb' #=> github url
load_template '/Users/olis/rails/application-templates/_authenticated.rb' if yes?("Do you need authentication?")
load_template '/Users/olis/rails/application-templates/_localized.rb' if yes?("Do you need internationalization?")

# Success!
  puts "SUCCESS!"