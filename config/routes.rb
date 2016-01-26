Rails.application.routes.draw do
  root                 'static_pages#home'
  get 'help'        => 'static_pages#help'
  get 'about'       => 'static_pages#about'
  get 'add_student' => 'users#new'
  resources :users
end
