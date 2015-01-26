namespace :deploy do
  desc <<-DESC
    Build your cache.

    By default this task will do nothing. At the bare minimum, you must
    configure the following options:

      set :public_cache_base_url, '' # the public base URL of your application
      set :public_cache_files, {}    # the source and destination paths of the
                                     # files you want to cache.

    See README.md for more information on these options.
  DESC
  task :restart_check do
    timeout_at = Time.now + fetch(:restart_check_timeout_threshold)
    on roles fetch(:restart_check_roles) do |host|
      restarted = false
      while Time.now < timeout_at
        expected_version = capture(:cat, current_path.join('REVISION'))
        running_version = capture(:curl, fetch(:restart_check_curl_flags), fetch(:restart_check_url))

        if expected_version.strip == running_version.strip
          restarted = true
          info('Application successfully restarted.')
          break
        else
          info("Application still restarting. Expecting #{expected_version}, running version is #{running_version}.")
          Kernel.sleep(10)
        end
      end
      warn("Application did not restart in #{fetch(:restart_check_timeout_threshold)} seconds on #{host.hostname}.") unless restarted
    end
  end
end

namespace :load do
  task :defaults do
    set :restart_check_timeout_threshold, 60
    set :restart_check_roles, :app
    set :restart_check_url, ''
    set :restart_check_curl_flags, '-f'
  end
end
