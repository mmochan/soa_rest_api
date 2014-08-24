class CompositeDeployments < MbeanConnection

  attr_accessor :data

  def initialize(server)
    @data = {:composites =>{}}
    super(server)
  end

  def composite_format composite
    keys = [ :full,  :deployed_time, :is_default, :location, :mode, :state]
    formatted = Hash[keys.zip composite.values.to_a]
    formatted[:name] = composite.values.to_a.first.split('/')[-1].split('!').first
    return formatted
  end

  def get_composites server_name, soaBean
    begin
    composites = getattr(soaBean, 'DeployedComposites')
     composites.each do |composite|
       comp = composite_format(composite)
       name = comp[:name]
       data[:composites]["#{server_name.to_sym}"][name] = comp
     end
     rescue
      data[:composites].delete("#{server_name.to_sym}")
     end  
  end

  def composite_deployment
    server_list.each do |server|
      server_name = getattr(server, "Name")
      data[:composites]["#{server_name.to_sym}"] = {}
      domain = getattr(@service, "DomainRuntime")
      soaBean = ObjectName.new("oracle.soa.config:Location=#{server_name},name=soa-infra,j2eeType=CompositeLifecycleConfig,Application=soa-infra")
      get_composites(server_name, soaBean)
    end
   return data
 end
end