Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'game#index'
   get '/game/start', as: 'new_game', to: 'game#new'
   get '/round/:round_id/ball/:ball_id', to: 'game#show', as: 'show_game', constraints: { round_id: /\d{1,2}/, ball_id: /[1-2]/ }
end
