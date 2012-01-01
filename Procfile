web:        bundle exec rails server
redis:      redis-server
scheduler:  bundle exec rake resque:scheduler
resque:     bundle exec rake resque:work QUEUE=* JOBS_PER_FORK=5
juggernaut: juggernaut --port 8080
