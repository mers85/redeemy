Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      post "/request_token" => "tokens#request_token"
      post "/authenticate_token" => "tokens#authenticate_token"
      resource :tokens,:only => [:destroy]

      resources :users, module: "users" do
         resources :type, only: %i[index]
      end

      resources :organizations, module: "organizations" do
        resources :redemptions
        resources :projects, only: [:index]
      end

      resources :org_admins, module: "org_admins" do
        resources :organization, only: %i[index]
      end

      resources :projects, only: %i[index show update create], module: "projects" do
        collection do
          resources :featured, only: %i[index]
        end
      end
      resources :categories, only: %i[index show]
      resources :point_types, only: %i[index]
      resources :customers, only: %i[index show], module: "customers" do
        resources :redemptions, only: %i[index]
      end

      post "/answers" => 'answers#get'
    end
  end


end
