WriterAppRor::Application.routes.draw do
  resources :projects
  resources :users

  devise_for :users

  root :to => 'welcome#index'
end
