class Mbean 

  def self.DomainService server
    connect = DomainServiceConnection.new(server)
    status = connect.server_runtimes
  end

  def self.RuntimeService server
    connect = RuntimeServiceConnection.new(server)
    status = connect.status
  end

  def self.EditService server
    connect = EditServiceConnection.new(server)
    status = connect.status
  end

  def self.jdbc_domain_configuration server
    connect = JdbcDomainConfiguration.new(server)
    status = connect.jdbc_configuration
  end

  def self.jms_domain_configuration server
    connect = JmsDomainConfiguration.new(server)
    status = connect.jms_configuration
  end  

  def self.composite_deployments server
    connect = CompositeDeployments.new(server)
    status = connect.composite_deployment
  end
end
