def create_gemfile
  remove_file "Gemfile"
  run "touch Gemfile" 
  add_source 'https://rubygems.org'
  gem 'rails',        '5.0.0.1'
  gem 'bcrypt', '3.1.11'
  gem 'users', github: 'nnabeyang/users-rails'
  gem 'starter-rails', github: 'nnabeyang/starter-rails'
  gem 'rails-i18n', '5.0.0'
  gem 'bootstrap-sass', '3.3.6'
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
end
