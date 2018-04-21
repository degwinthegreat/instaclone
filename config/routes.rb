Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  root to: 'sessions#new'
  resources :favorites, only: [:index, :create, :destroy]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  resources :photos do
    collection do
      post :confirm
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
