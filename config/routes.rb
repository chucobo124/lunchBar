Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/attendants/lead_us', to: 'attendants#lead'
end
