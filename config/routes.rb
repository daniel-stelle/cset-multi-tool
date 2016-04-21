Rails.application.routes.draw do
  root                      'sessions#new'
  get    'help'          => 'static_pages#help'
  get    'about'         => 'static_pages#about'
  post   'login'         => 'sessions#create'
  delete 'logout'        => 'sessions#destroy'
  delete 'remove_worker' => 'relationships#destroy'
  
  resources :users
  resources :timesheets do
    member do
      post 'clock_in'      => 'timesheets#clock_in'
      post 'clock_out'     => 'timesheets#clock_out'
    end
  end
  resources :workers,        only:   [:new, :index, :create, :show]
  resources :timesheet_rows, except: [:new, :create]
  resources :relationships
end