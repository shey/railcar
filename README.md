# Railcar

Welcome to Railcar, your quick-start Rails 7 solution, specifically designed to work seamlessly with the Railroad server configuration.

Railcar is a fully setup Rails 7.0.5 application and the the companion to the Railroad Ansible project. It provides you with a Docker-free setup to kickstart your Rails application development.

### Key Features
* Rails 7.0.5
* Tailwind CSS
* Capistrano
* Postgresql
* Unicorn
* Ruby 3.1.2

## Getting Started
To get started with Railcar:

Download or clone both the [Railcar](https://github.com/shey/railcar/) and [Railroad](https://github.com/shey/railroad) repositories.

1. Set up your Ubuntu server using the Railroad Ansible project to ensure compatibility.
1. In the Railcar repository, navigate to `config/deploy/production.rb` and update it with your server's IP address.
1. In the deployment script, `config/deploy.rb`, update the `repo_url` with the URL to your repo.

## Environment Variables
In Railcar, environment variables are handled by Railroad. It's worth noting that Railcar does not use Rails' built-in `credentials.yml` file for environment management. Ensure that your copy of the Railroad repo has env vars defined in and copied over to the `.env` file on the remote host.

## Deploying

#### Make ssh-agent happy
pkill ssh-agent && eval `ssh-agent` ^C  ssh-add ~/.ssh/id_rsa

#### Confirm access to git
SSH into your server, `ssh rails@yourappdomain.com`, and run `ssh -T git@github.com` to ensure your keys are forwarded to Github.

#### First-time Deploy
From the root of the app, first run `bundle exec cap production deploy:setup` to setup the directories on the remote host, and then run `bundle exec cap production deploy` to deploy the app.

#### Subsequent Deploys
From the root of the app run `bundle exec cap production deploy` or use the helper `make deploy`. By default `capistrano` will deploy the `main` branch from your git repo.

## License
Railcar is open-source software, licensed under [The MIT License](LICENSE).

## Support
For support and additional queries, please contact shey@shey.ca.

Note: Railcar is designed to be used in conjunction with the Railroad Ansible project. For optimal results, I recommend deploying Railcar to a server configured using Railroad.
