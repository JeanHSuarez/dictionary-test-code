Rails.application.routes.draw do
  get 'oxford_dictionary/index'
  

  root 'oxford_dictionary#index'

  get 'oxford_dictionary/lookup', to: "oxford_dictionary#lookup"
end
