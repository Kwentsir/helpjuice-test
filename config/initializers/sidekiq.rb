require 'sidekiq/cron/job'


Sidekiq::Cron::Job.create(
  name: 'Finalize search sessions - every minute',
  cron: '*/1 * * * *', 
  class: 'FinalizeSearchSessionJob'
)
