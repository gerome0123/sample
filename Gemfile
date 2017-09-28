eval(File.read(File.dirname(__FILE__) + '/common_dependencies.rb'))

# gem 'btr_rms_migrator', path: 'migrator'

## Rails
gem 'rails', '~> 5.0'
gem 'rails-i18n'

gem 'active_model_serializers'
gem 'acts_as_list'
gem 'ancestry'
gem 'paper_trail'
gem 'paperclip'

gem 'cancancan', git: 'https://github.com/CanCanCommunity/cancancan.git', branch: 'master'
gem 'rolify'

gem 'postmark-rails'
gem 'progress_bar'
gem 'time_difference'

## Web Server
gem 'foreman'
gem 'puma'

## Configurator
gem 'figaro'

## HTML/CSS sanitizer & parser
gem 'css_parser'
gem 'sanitize'

## Documentation
group :doc do
  gem 'sdoc'
end

## Spreadsheet Converter
gem 'roo', git: 'https://github.com/roo-rb/roo.git'

## View Helper
gem 'kaminari'
gem 'slim-rails'
gem 'valid_email', require: 'valid_email/all_with_extensions'

## Assets
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0.0'
gem 'uglifier', '~> 2.5.3'

gem 'autoprefixer-rails'
gem 'js-routes'
gem 'zeroclipboard-rails'
source 'https://rails-assets.org/' do
  gem 'rails-assets-html5shiv'
  gem 'rails-assets-jquery'
  gem 'rails-assets-respond'

  gem 'rails-assets-angular', '~> 1.5.0'
  gem 'rails-assets-angular-animate'
  gem 'rails-assets-angular-aria'
  gem 'rails-assets-angular-cookies'
  gem 'rails-assets-angular-material', '1.1.1'
  gem 'rails-assets-angular-messages'
  gem 'rails-assets-angular-resource'
  gem 'rails-assets-angular-route'
  gem 'rails-assets-angular-sanitize'

  gem 'rails-assets-angular-moment'
  gem 'rails-assets-moment'

  gem 'rails-assets-angular-translate'
  gem 'rails-assets-angular-translate-loader-partial'
  gem 'rails-assets-angular-translate-loader-static-files'
  gem 'rails-assets-angular-translate-storage-cookie'
  gem 'rails-assets-angular-translate-storage-local'

  gem 'rails-assets-angular-filter'
  gem 'rails-assets-angularjs-viewhead'

  gem 'rails-assets-fastclick'
  gem 'rails-assets-jquery.browser'
  gem 'rails-assets-jquery.scrollTo'
  gem 'rails-assets-string'
  gem 'rails-assets-velocity'

  gem 'rails-assets-angular-file-model'
  gem 'rails-assets-angular-file-upload'

  gem 'rails-assets-angular-xeditable'
  gem 'rails-assets-lodash'
  gem 'rails-assets-md-data-table'
  gem 'rails-assets-angular-drag-and-drop-lists'
end

## Security
gem 'devise'
gem 'devise-encryptable'
gem 'devise_database_pwd',
    git: 'https://github.com/tenshiAMD/devise_database_pwd.git'
gem 'devise_security_extension',
    git: 'https://github.com/phatworx/devise_security_extension.git'
gem 'doorkeeper', '~> 4.0.0'
gem 'ip_auth',
    git: 'https://github.com/tenshiAMD/ip_auth.git'
gem 'ng-rails-csrf'
gem 'recaptcha'
gem 'secure_headers', '~> 2.5.0'

## Remote Development
group :development do
  gem 'capistrano', '~> 3.6.0'
  gem 'capistrano-bundler', require: false
  gem 'capistrano-docker', git: 'https://github.com/netguru/capistrano-docker', require: false
  gem 'capistrano-file-permissions', require: false
  gem 'capistrano-nc', require: false
  gem 'capistrano-pending', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-safe-deploy-to', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano-ssh-doctor', require: false
  gem 'capistrano3-puma', require: false
end

## Jobs
gem 'sidekiq'

## PDF 
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

## Search Engine
gem 'sunspot'
gem 'sunspot_rails'
group :development, :test do
  gem 'sunspot_solr'
end
gem 'sunspot-queue'
