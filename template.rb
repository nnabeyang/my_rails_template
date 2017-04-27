require File.expand_path("../gemfile.rb", __FILE__)
def config_bundle
  empty_directory ".bundle"
  create_file(".bundle/config") do <<'RUBY'
---
BUNDLE_JOBS: 4
BUNDLE_WITHOUT: "production"
RUBY
  end
end
create_gemfile
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
  config.i18n.default_locale = :ja
RUBY
end
after_bundle do
  run "bin/spring stop"
  get 'https://raw.githubusercontent.com/nnabeyang/my_rails_template/master/Gurdfile', 'Guardfile'
  get 'https://raw.githubusercontent.com/nnabeyang/my_rails_template/master/ja.yml', 'config/locale/ja.yml'
  generate "controller", "Welcome index"
  generate "users", "users"
  run "rails db:migrate"
  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
end
