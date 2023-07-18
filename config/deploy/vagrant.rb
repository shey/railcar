set :rails_env, 'production'

role :app, %w{rails@192.168.56.41}
role :db,  %w{rails@192.168.56.41}
