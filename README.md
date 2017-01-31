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

    set :delayed_job, lambda { "bin/delayed_job" }

Sets the dir to the pid files of a delayed_job workers

    set :delayed_job_pid_dir, 'pids'

Sets the number of delayed_job processes launched

    set :delayed_job_processes, 1

Sets some additional parameters

    set :delayed_job_additional_params, ''

### Usage example

    require 'mina/delayed_job'

    task :deploy do
      deploy do
        invoke :'git:clone'
        ...

        on :launch do
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
