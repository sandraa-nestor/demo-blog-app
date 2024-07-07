
Rails.application.routes.draw do
  mount MaintenanceTasks::Engine => "/maintenance_tasks"
  mount Motor::Admin => '/motor_admin'

  resources :posts, param: :slug do
    resources :comments, only: :create
  end
  root 'posts#index'
end
