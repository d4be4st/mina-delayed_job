# Modules: DelayedJob

Mina plugin to manage delayed_jobs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-delayed_job', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mina-delayed_job

## Usage

### Settings
Any and all of these settings can be overriden in your `deploy.rb`.

Sets the path to delayed_job.

    set_default :delayed_job, lambda { "bin/delayed_job" }

Sets the dir to the pid files of a delayed_job workers

    set_default :delayed_job_pid_dir, lambda { "#{deploy_to}/#{shared_path}/pids" }

Sets the number of delayed_job processes launched

    set_default :delayed_job_processes, 1

### Usage example

    require 'mina/delayed_job'
    ...
    task :setup do
      # delayed_job needs a place to store its pid file
      invoke :'delayed_job:setup'
    end

    task :deploy do
      deploy do
        invoke :'git:clone'
        ...

        to :launch do
          ...
          invoke :'delayed_job:restart'
        end
      end
    end

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mina-delayed_job/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
