require 'sidekiq/web'
require 'sidekiq/cron/web'
  
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'bit_coins#index'
end
