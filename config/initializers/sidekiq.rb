require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0') }

  config.on(:startup) do

    schedule_file = Rails.root.join("config/sidekiq.yml")
    puts "[sidekiq] Loading schedule file from: #{schedule_file}" # ✅ ADD THIS LINE
  
    if File.exist?(schedule_file)
      raw_schedule = YAML.load_file(schedule_file)

      if raw_schedule.is_a?(Hash)
        schedule = raw_schedule.dig(:scheduler, :schedule)
        puts "[sidekiq] extracted schedule: #{schedule.inspect}"
        
        Sidekiq.schedule = schedule if schedule.is_a?(Hash)
        Sidekiq::Scheduler.reload_schedule! if Sidekiq.schedule.present?
      else
        puts "[sidekiq] YAML loaded but not a Hash: #{raw_schedule.class}"
      end
    else
      puts "[sidekiq] schedule file not found!"
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://redis:6379/0') }
end
