require 'mina/bundler'
require 'mina/rails'

set :delayed_job, 'bin/delayed_job'
set :delayed_job_pid_dir, 'pids'
set :delayed_job_processes, 1
set :delayed_job_additional_params, ''
set :shared_dirs, fetch(:shared_dirs, []).push(fetch(:delayed_job_pid_dir))

namespace :delayed_job do
  desc 'Stop delayed_job'
  task stop: :remote_environment do
    comment 'Stop delayed_job'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:rails_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} stop --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end

  desc 'Start delayed_job'
  task start: :remote_environment do
    comment 'Start delayed_job'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:rails_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} start -n #{fetch(:delayed_job_processes)} --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end

  desc 'Restart delayed_job'
  task restart: :remote_environment do
    comment 'Restart delayed_job'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:rails_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} restart -n #{fetch(:delayed_job_processes)} --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end

  desc 'delayed_job status'
  task status: :remote_environment do
    comment 'Delayed job Status'
    in_path(fetch(:current_path)) do
      command "RAILS_ENV='#{fetch(:rails_env)}' #{fetch(:delayed_job)} #{fetch(:delayed_job_additional_params)} status --pid-dir='#{fetch(:shared_path)}/#{fetch(:delayed_job_pid_dir)}'"
    end
  end
end
