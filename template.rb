def config_bundle
  empty_directory ".bundle"
  create_file(".bundle/config") do <<'RUBY'
---
BUNDLE_JOBS: 4
BUNDLE_WITHOUT: "production"
RUBY
  end
end


remove_file "Gemfile"
run "touch Gemfile" 
add_source 'https://rubygems.org'
gem 'rails',        '5.0.0.1'
gem 'puma',         '3.4.0'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.0.0'
gem 'coffee-rails', '4.2.1'
gem 'jquery-rails', '4.1.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.4.1'

gem_group :development, :test do
  gem 'sqlite3', '1.3.11'
  gem 'byebug',  '9.0.0', platform: :mri
end

gem_group :development do
  gem 'web-console',           '3.1.1'
  gem 'listen',                '3.0.8'
  gem 'spring',                '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
end

gem_group :test do
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters', '1.1.9'
  gem 'guard', '2.13.0'
  gem 'guard-minitest', '2.4.4'
  gem 'terminal-notifier-guard', '1.6.4'
end

gem_group :production do
 gem 'pg', '0.18.4'
end

config_bundle
route "root 'welcome#index'"
inject_into_file "test/test_helper.rb", after: "require 'rails/test_help'" do<<'RUBY'

require 'minitest/reporters'
Minitest::Reporters.use!     
RUBY
end
inject_into_file "config/application.rb", after: "# -- all .rb files in that directory are automatically loaded." do<<'RUBY'

  config.generators do |g|
    g.assets false
  end
RUBY
end
after_bundle do
  run "bin/spring stop"
  get 'https://gist.githubusercontent.com/nnabeyang/435005a54c23865642fb93728a242950/raw/Guardfile', 'Guardfile'
  generate "controller", "Welcome index"
  generate "model", "user name:string email:string"
  run "rails db:migrate"
  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
end
