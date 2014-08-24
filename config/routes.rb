require 'api_version'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
#  namespace :api, path: '/', constraints: { subdomain: 'api' } do 
#    resources :jdbc_configs    
#    resources :environments
#  end  

  #scope defaults: {format: 'json'} do
  #  scope module: :v1, constraints: ApiVersion.new('v1') do 
  #    get '', to: 'users#show', param: :name
  #    resources :environments, param: :name do 
  #     resources :jdbc_configs
  #    end
  #  end
  #end


#scope defaults: { format: 'json'} do 
#  scope module: :v1, constraints: ApiVersion.new('v1', true) do 
#    resources :environments, param: :name 
#  end
#  
#  scope module: :v2, constraints: ApiVersion.new('v2') do 
#    resources :environments, param: :name 
#  end
#end

# mbeans tree
# ===========
# custom
# domainConfig
# domainRuntime
# edit
# jndi
# serverConfig
# serverRuntime

  namespace :v1 do 
    resources :environments, param: :name, only: [:index]  do 
        resources :jdbc_configs, only: [:index]
     end    
    get ':name', to: 'environments#show', param: :name     

    get ':name/config', to: 'mbeans#domainservice'    
    get ':name/domain', to: 'mbeans#domainservice'    
    get ':name/runtime', to: 'mbeans#runtimeservice'
    get ':name/edit', to: 'mbeans#editservice'

    get ':name/config/jdbc', to:  'mbeans#jdbc_domain_configuration'
    get ':name/config/jms', to:  'mbeans#jms_domain_configuration'
    get ':name/config/composites', to:  'mbeans#composite_deployments'

    #get ':name/config/jdbc/datasources', to:  'mbeans#domainservice_jdbc_datasource'    

    
  end  

  #constraints subdomain: 'api' do
  #  scope module: 'api' do
  #    get '', to: 'environments#show', param: :name
  #    resources :environments, param: :name, only: [:index] do 
  #      resources :jdbc_configs, only: [:index]
  #    end
  #  end
  #end  
#
    #scope module: :v2, constraints: ApiVersion.new('v1') do 
    #  resource :environments
    #  resource :jdbc_configs
    #end
  #end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
