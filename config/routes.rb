Rails.application.routes.draw do

  root 'game#index'

  get '/game/start', as: 'create_game', to: 'game#create'
 
  get 'game/:id/round/:round_id/ball/:ball_id', to: 'game#show', 
    as: 'show_game', constraints: { round_id: /\d{1,2}/, ball_id: /[1-2]/ }

  put 'game/:id/round/:round_id/ball/:ball_id/hits/:pins', 
    constraints: { round_id: /\d{1,2}/, ball_id: /[1-2]/, hits: /\d{1,2}/ },
    to: 'game#update', as: 'update_game'

  get 'game/:id/finished', to: 'game#finished', as: 'finished_game'
end
