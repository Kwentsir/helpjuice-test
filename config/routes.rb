Rails.application.routes.draw do
  namespace :api do
    post 'search_queries', to  'search_queries#create'
    get '/popular', to: '#popular'
end
