Rails.application.routes.draw do
  get "contact_forms/new"
  get "contact_forms/create"
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
  get "contact", to: "pages#contact"
  get "services", to: "pages#services"
  get "dog_walking_guide", to: "pages#dog_walking_guide"
  get "terms", to: "pages#terms_and_conditions"
  get "privacy", to: "pages#privacy_policy"
  get "weather_policy", to: "pages#weather_policy"

  # Using singular controller name (BlogController)
  resources :blogs, only: [ :index, :show ]

  get "/blogs/:slug", to: "blogs#show", as: :blogs_post

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :contact_forms, only: [ :new, :create ] do
    collection do
      get :thank_you
    end
  end
end
