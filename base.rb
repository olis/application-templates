# Delete unnecessary files
  run "rm public/index.html"

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
  plugin 'acts_as_list', :git => 'git://github.com/rails/acts_as_list.git'
  plugin 'acts_as_tree', :git => 'git://github.com/rails/acts_as_tree.git'
  plugin 'exception_notification', :git => 'git://github.com/rails/exception_notification.git'
  plugin 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'
  plugin 'selenium-on-rails', :git => 'git://github.com/paytonrules/selenium-on-rails.git'
  plugin 'will_paginate', :git => 'git://github.com/mislav/will_paginate.git'

# Download JQuery
  run "curl -L http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js > public/javascripts/jquery-1.3.2.min.js"
  run "curl -L http://jqueryjs.googlecode.com/svn/trunk/plugins/form/jquery.form.js > public/javascripts/jquery.form.js"
  
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
