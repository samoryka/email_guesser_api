Rails.application.routes.draw do
  post 'derive', to: 'emails#derive'
end
