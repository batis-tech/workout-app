require 'sidekiq/web'

Rails.application.routes.draw do

    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  class Subdomain
    def self.matches?(request)
      subdomains = %w{ www admin }
      request.subdomain.present? && !subdomains.include?(request.subdomain)
    end
  end

  constraints Subdomain do
     resources :workouts
  end
  devise_for :users
  root to: 'home#index'
  
end
