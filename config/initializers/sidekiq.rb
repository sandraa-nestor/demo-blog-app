Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/' }
  config.logger = Logger.new(Rails.root.join('log', 'sidekiq.log'))
  config.logger.level = Logger::INFO
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/' }
end
