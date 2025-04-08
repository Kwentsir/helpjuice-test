Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    post 'search_queries', to:  'search_queries#create'
    get 'popular', to: 'analytics#popular'
  end
end
