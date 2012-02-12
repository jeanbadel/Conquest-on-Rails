web:        bundle exec rails server --port 3000
redis:      redis-server config/redis.conf
scheduler:  bundle exec rake resque:scheduler
resque:     bundle exec rake resque:work QUEUE=* JOBS_PER_FORK=5
juggernaut: juggernaut --port 8080
