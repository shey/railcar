set :rails_env, 'production'

role :app, %w{rails@stg-name-app01.outage.name}
role :db,  %w{rails@stg-name-app01.outage.name}
