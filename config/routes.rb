ConquestOnRailsDev::Application.routes.draw do
  root to: 'application#home'

  post '/users', to: 'users#create', as: 'users'

  post   '/sign_in',  to: 'sessions#create',  as: 'sign_in'
  delete '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  get '/dashboard', to: 'users#dashboard'

  post '/games/find', to: 'games#find', as: 'find_game'
  get  '/games/:id',  to: 'games#show', as: 'game'

  scope '/games/:game_id' do
    post '/attacks', to: 'attacks#create', as: 'attacks'
  end
end
