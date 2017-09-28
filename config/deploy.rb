# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'sample'
set :repo_url, 'git@github.com:gerome0123/sample.git'
set :branch, 'master'
set :deploy_to, -> { "/var/www/#{fetch(:application)}" }

# Default value for :linked_files is []
set :docker_copy_data, fetch(:linked_files, []).push('docker/web/.env', 'config/application.yml')

# Default value for keep_releases is 5
set :keep_releases, 5

set :log_level, :info

set :bundle_flags, '--deployment --quiet'

set :docker_role, :web
set :docker_compose_up_services, 'web load_balancer worker'
set :docker_compose, true
set :docker_compose_project_name, -> { fetch(:application) }
set :docker_assets_precompile_command, -> { 'bundle exec rake assets:precompile && bundle exec rake assets:clean' }
set :docker_assets_non_digested_command, -> { 'bundle exec rake assets:non_digested' }
set :docker_migrate_command, -> { 'bundle exec rake db:migrate' }
set :docker_compose_path, -> { release_path.join('docker-compose.prod.yml') }

namespace :docker do
  namespace :rails do
    def docker_compose_execute(exec)
      cmd = ['run --rm'] # --rm, Remove container after run
      cmd.unshift("-p #{fetch(:docker_compose_project_name)}") unless fetch(:docker_compose_project_name).nil?
      cmd.unshift("-f #{fetch(:docker_compose_path)}")
      cmd << "web bash -c '#{exec}'"

      cmd.join(' ')
    end

    task :bundle do
      on release_roles(fetch(:docker_role)) do
        within release_path do
          options = []
          options << "--gemfile #{fetch(:bundle_gemfile)}" if fetch(:bundle_gemfile)
          options << "--path #{fetch(:bundle_path)}" if fetch(:bundle_path)
          unless test(:'docker-compose', docker_compose_execute("bundle check #{options.join(' ')}"))
            options << "--binstubs #{fetch(:bundle_binstubs)}" if fetch(:bundle_binstubs)
            options << "--jobs #{fetch(:bundle_jobs)}" if fetch(:bundle_jobs)
            options << "--without #{fetch(:bundle_without)}" if fetch(:bundle_without)
            options << fetch(:bundle_flags).to_s if fetch(:bundle_flags)
            execute :'docker-compose', docker_compose_execute("bundle install #{options.join(' ')}")
          end
        end
      end
    end

    namespace :assets do
      task :precompile do
        on release_roles(fetch(:docker_role)) do
          within release_path do
            execute :'docker-compose', docker_compose_execute(fetch(:docker_assets_precompile_command))
          end
        end
      end
    end

    namespace :db do
      task :migrate do
        on release_roles(fetch(:docker_role)) do
          within release_path do
            execute :'docker-compose', docker_compose_execute(fetch(:docker_migrate_command))
          end
        end
      end
    end

    def _compose_option_up_services
      opt = fetch(:docker_compose_up_services)
      opt.nil? ? '' : opt
    end

    def compose_start_command
      cmd = %w[up -d]
      cmd << _compose_option_up_services
      cmd.unshift _compose_option_project_name
      cmd.unshift _compose_option_compose_path

      cmd.join(' ')
    end
  end
end

after 'docker:deploy:compose:build', 'docker:rails:bundle'
after 'docker:rails:bundle', 'docker:rails:db:migrate'
after 'docker:rails:bundle', 'docker:rails:assets:precompile'
