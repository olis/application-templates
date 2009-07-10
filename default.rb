
load_template 'http://github.com/olis/application-templates/base.rb' #=> github url
load_template 'http://github.com/olis/application-templates/_authenticated.rb' if yes?("Do you need authentication?")
load_template 'http://github.com/olis/application-templates/_localized.rb' if yes?("Do you need internationalization?")

# Success!
  puts "SUCCESS!"