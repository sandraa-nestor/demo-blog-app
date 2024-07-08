require 'sidekiq/web'

Rails.application.routes.draw do
  mount MaintenanceTasks::Engine => "/maintenance_tasks"
  mount Motor::Admin => '/motor_admin'
  mount Sidekiq::Web => '/sidekiq'

  resources :posts, param: :slug do
    resources :comments, only: :create
  end
  root 'posts#index'
end
