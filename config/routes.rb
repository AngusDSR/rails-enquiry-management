Rails.application.routes.draw do
  root 'enquiries#new'
  resource :enquiries, only: %i[index new create]
end
