# # Modules: DelayedJob
# Adds settings and tasks for managing DelayedJob workers.
#
# ## Usage example
#     require 'mina_delayed_job/tasks'
#     ...
#     task :setup do
#       # delayed_job needs a place to store its pid file
#       queue! %[mkdir -p "#{deploy_to}/shared/pids/"]
#     end
#
#     task :deploy do
#       deploy do
#         invoke :'git:clone'
#         ...
#
#         to :launch do
#           ...
#           invoke :'delayed_job:restart'
#         end
#       end
#     end

require 'mina/bundler'
require 'mina/rails'

# ## Settings
# Any and all of these settings can be overriden in your `deploy.rb`.

# ### delayed_job
# Sets the path to delayed_job.
set_default :delayed_job, lambda { "bin/delayed_job" }

# ### delayed_job_pid_id
# Sets the dir to the pid files of a delayed_job workers
set_default :delayed_job_pid_dir, lambda { "#{deploy_to}/#{shared_path}/pids" }

# ### delayed_job_processes
# Sets the number of delayed_job processes launched
set_default :delayed_job_processes, 1

# ## Control Tasks
namespace :delayed_job do
  # ### delayed_job:stop
  desc "Stop delayed_job"
  task :stop => :environment do
    queue %[echo "-----> Stop delayed_job"]
    queue %[
      cd "#{deploy_to}/#{current_path}"
      #{echo_cmd %[#{rails_env} #{delayed_job} stop --pid_dir=#{delayed_job_pid_dir}]}
    ]
  end

  # ### delayed_job:start
  desc "Start delayed_job"
  task :start => :environment do
    queue %[echo "-----> Start delayed_job"]
    queue %{
      cd "#{deploy_to}/#{current_path}"
      #{echo_cmd %[#{rails_env} #{delayed_job} -n #{delayed_job_processes} --pid_dir=#{delayed_job_pid_dir start }] }
    }
  end

  # ### delayed_job:restart
  desc "Restart delayed_job"
  task :restart => :environment do
    queue %[echo "-----> Restart delayed_job"]
    queue %{
      cd "#{deploy_to}/#{current_path}"
      #{echo_cmd %[#{rails_env} #{delayed_job} -n #{delayed_job_processes} --pid_dir=#{delayed_job_pid_dir restart}] }
    }
  end

  # ### delayed_job:status
  desc "delayed_job status"
  task :status => :environment do
    queue %[echo "-----> Delayed_job Status"]
    queue %{
      cd "#{deploy_to}/#{current_path}"
      #{echo_cmd %[#{rails_env} #{delayed_job} --pid_dir=#{delayed_job_pid_dir status}] }
    }
  end
end
