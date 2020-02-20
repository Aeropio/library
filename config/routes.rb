Rails.application.routes.draw do
  #devise_for :users
  get 'users/approve_user' => 'users#approve_user', as: :approve_user
  get 'users/reject_user' => 'users#reject_user', as: :reject_user
  
  resources :users 

  devise_for :admins

  

  # devise_scope :admins do
  #   authenticated :admin do
  #     root 'users#index', as: :authenticated_root
  #   end

  #   unauthenticated do
  #     root 'devise/sessions#new', as: :unauthenticated_root
  #   end
  # end
end
