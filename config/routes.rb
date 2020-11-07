Rails.application.routes.draw do
  get 'dictionary/index'
  

  root 'dictionary#index'

  get 'dictionary/lookup', to: "dictionary#lookup"
end
