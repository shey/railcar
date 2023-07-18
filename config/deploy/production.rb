set :rails_env, 'production'

role :app, %w{rails@prod-app01.yourappdomain.com}
role :db,  %w{rails@prod-app01.yourappdomain.com}
