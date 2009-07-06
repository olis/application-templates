load_template './base.rb'

plugin 'localized_dates', :git => 'git://github.com/clemens/localized_dates.git', :submodule => true
git :submodule => "init"

# Setup I18N
  initializer 'internationalization', <<-END
I18n.default_locale = 'de'
I18n.load_path << Dir[ File.join(RAILS_ROOT, 'config', 'locales', '**/**/*.{rb,yml}') ]

LOCALES_DIRECTORY = "#{RAILS_ROOT}/config/locales/"
LOCALES_AVAILABLE = Dir.new(LOCALES_DIRECTORY).entries.collect {|x| x =~ /\.rb/ ? x.sub(/\.rb/,"") : nil }.compact
  END

git :add => ".", :commit => "-m 'Internationalization'"