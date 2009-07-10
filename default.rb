
load_template 'http://github.com/olis/application-templates/raw/master/base.rb' #=> github url
load_template 'http://github.com/olis/application-templates/raw/master/_authenticated.rb' if yes?("Do you need authentication?")
load_template 'http://github.com/olis/application-templates/raw/master/_localized.rb' if yes?("Do you need internationalization?")

# Success!
  puts "SUCCESS!"