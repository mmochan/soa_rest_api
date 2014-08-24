module V1
  class MbeansController < ApplicationController
    before_filter :cors_preflight_check, :cors_set_access_control_headers

    def domainservice
      server = Environment.where(name: params[:name]).first
      if server.nil?
        render json: {:invalid_environment => "You need to pass a valid environment"} , status: 200
      else
        domain_service = Mbean.DomainService(server)
        render json: domain_service, status: 200
      end
    end
    def runtimeservice
      server = Environment.where(name: params[:name]).first
      runtime_service = Mbean.RuntimeService(server)
      render json: runtime_service, status: 200
    end

    def editservice
      server = Environment.where(name: params[:name]).first
      edit_service = Mbean.EditService(server)
      render json: edit_service, status: 200
    end

    def jdbc_domain_configuration
      server = Environment.where(name: params[:name]).first
      if server.nil?
        render json: {:invalid_environment => "You need to pass a valid environment"} , status: 200
      else
        domain_service = Mbean.jdbc_domain_configuration  (server)
        render json: domain_service, status: 200
      end   
    end 

    def jms_domain_configuration
      server = Environment.where(name: params[:name]).first
      if server.nil?
        render json: {:invalid_environment => "You need to pass a valid environment"} , status: 200
      else
        domain_service = Mbean.jms_domain_configuration  (server)
        render json: domain_service, status: 200
      end      
    end 

    def composite_deployments
      server = Environment.where(name: params[:name]).first
      if server.nil?
        render json: {:invalid_environment => "You need to pass a valid environment"} , status: 200
      else
        composites = Mbean.composite_deployments  (server)
        render json: composites, status: 200
      end      
    end 

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Max-Age'] = "1728000"
    end

    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
        headers['Access-Control-Max-Age'] = '1728000'
        render :text => '', :content_type => 'text/plain'
      end
    end    
  end
end
