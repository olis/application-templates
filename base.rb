# Delete unnecessary files
  run "rm public/index.html"
  run "rm -f public/javascripts/*"

# Download JQuery
  run "curl -L http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js > public/javascripts/jquery.js"
  run "curl -L http://jqueryjs.googlecode.com/svn/trunk/plugins/form/jquery.form.js > public/javascripts/jquery.form.js"

# Set up git repository
  git :init
  git :add => '.'
  
# Copy database.yml for distribution use
  run "cp config/database.yml config/database.yml.example"
  
# Set up .gitignore files
  run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
  run %{find . -type d -empty | grep -v "vendor" | grep -v ".git" | grep -v "tmp" | xargs -I xxx touch xxx/.gitignore}
  file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

# Install submodules plugins
  plugin 'acts_as_list', :git => 'git://github.com/rails/acts_as_list.git', :submodule => true
  plugin 'acts_as_tree', :git => 'git://github.com/rails/acts_as_tree.git', :submodule => true
  plugin 'exception_notification', :git => 'git://github.com/rails/exception_notification.git', :submodule => true
  plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git', :submodule => true
  plugin 'selenium-on-rails', :git => 'git://github.com/paytonrules/selenium-on-rails.git', :submodule => true
  plugin 'sprocket-rails', :git => 'git://github.com/sstephenson/sprockets-rails.git', :submodule => true
  plugin 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git', :submodule => true
  
# Initialize submodules
  git :submodule => "init"
  
# Install all gems
  gem 'sprockets'
  gem "thoughtbot-shoulda", :lib => "shoulda", :source => "http://gems.github.com"
  rake 'gems:install', :sudo => true
  
# Setup exception notification
  address = ask("From which sender address should exception emails come from? (e.g. MyApp Errors, <errors@myapp.net>)")
  recipients = ask("Which email adresses should get exception emails? (comma seperated)")
  initializer 'exception_notification.rb', <<-END
ExceptionNotifier.exception_recipients = '#{recipients.split(/,/).collect(&:strip)}'
ExceptionNotifier.sender_address = '#{address.split(/,/).collect(&:strip)}'
  END
  
# Commit initial version
  git :add => '.'
  git :commit => "-a -m 'Initial commit'"
