namespace :unicorn do
  desc 'Start Unicorn'
  task :start do
    on roles(:app) do
      info "Starting Unicorn"
      execute "sudo /usr/sbin/service unicorn start"
    end
  end

  desc 'Stop Unicorn'
  task :stop do
    on roles(:app) do
      info "Stopping Unicorn"
      execute "sudo /usr/sbin/service unicorn stop"
    end
  end

  desc 'Restart Unicorn'
  task :hard_restart do
    on roles(:app) do
      info 'Hard-Restarting Unicorn'
      invoke 'unicorn:stop'
      invoke 'unicorn:start'
    end
  end

  desc 'Restart Unicorn'
  task :restart do
    on roles(:app) do
      info 'Restarting Unicorn gracefully'
      execute "sudo /usr/sbin/service unicorn upgrade"
    end
  end

  desc 'Reload Unicorn Config'
  task :reload do
    on roles(:app) do
      info 'Reloading Unicorn'
      execute "sudo /usr/sbin/service unicorn reload"
    end
  end
end
