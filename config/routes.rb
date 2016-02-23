Rails.application.routes.draw do
  root                      'sessions#new'
  get    'help'          => 'static_pages#help'
  get    'about'         => 'static_pages#about'
  get    'add_student'   => 'users#new'
  #get    'login'         => 'sessions#new'
  post   'login'         => 'sessions#create'
  delete 'logout'        => 'sessions#destroy'
  
  resources :users do
    resources :timesheets do
      member do
        post 'clock_in'      => 'timesheets#clock_in'
        post 'clock_out'     => 'timesheets#clock_out'
      end
      #resources :timesheet_rows
    end
  end



  resources :timesheet_rows, except: [:new, :create]




end