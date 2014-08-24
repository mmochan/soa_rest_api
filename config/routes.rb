require 'api_version'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

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
end
