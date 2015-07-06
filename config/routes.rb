Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'game#index'
   get 'round/:round_id/ball/:ball_id', to: 'game#new', as: 'new_game', round_id: /\d{2}/, ball_id: /[1-2]/
end
