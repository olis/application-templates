plugin 'restful_authentication', :git => 'git://github.com/technoweenie/restful-authentication.git', :submodule => true
git :submodule => "init"

# Setup user model
generate "authenticated", "user session"
rake 'db:migrate'

git :add => ".", :commit => "-m 'Authentication'"

