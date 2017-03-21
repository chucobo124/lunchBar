Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/attendants/lead/:id', to: 'attendants#lead', as: 'attendants_lead'
end
