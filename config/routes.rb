Rails.application.routes.draw do
  namespace :v1 do
    resources :tournaments
  end
end
