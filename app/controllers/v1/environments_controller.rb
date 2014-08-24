module V1
  class EnvironmentsController < ApplicationController
    before_filter :cors_preflight_check
    after_filter :cors_set_access_control_headers

    def index
      environments = Environment.all
      if environments.empty?
        render json: {:oh_crap =>"We appear to be missing the environment definitions"} , status: 200
      else 
        render json: environments,   status: 200, :except => [:password, :created_at, :updated_at]
      end
    end

    def show
      environment = Environment.where(name: params[:name]).first
      if environment.nil?
        render json: {:environment_controller => "You need to pass a valid environment"} , status: 200
      else 
        render json: environment, status: 200, :except => [:password, :created_at, :updated_at]
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

