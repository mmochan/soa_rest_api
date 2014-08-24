require "java"
require "timeout"

java_import "java.io.IOException"
java_import "java.net.MalformedURLException"
java_import "java.util.Hashtable"
java_import "javax.management.MBeanServerConnection"
java_import "javax.management.MalformedObjectNameException"
java_import "javax.management.ObjectName"
java_import "javax.management.remote.JMXConnector"
java_import "javax.management.remote.JMXConnectorFactory"
java_import "javax.management.remote.JMXServiceURL"
java_import "javax.naming.Context"


class MbeanConnection
  def initialize(server)
    @jndiroot = "/jndi/"
    @mserver = "weblogic.management.mbeanservers.domainruntime"
    @service_url = JMXServiceURL.new(server[:protocol], server[:adminUrl], server[:port], @jndiroot + @mserver)
    @service = ObjectName.new( "com.bea:Name=DomainRuntimeService,Type=weblogic.management.mbeanservers.domainruntime.DomainRuntimeServiceMBean")
    h = Hashtable.new
    h.put(Context.SECURITY_PRINCIPAL, server[:user])
    h.put(Context.SECURITY_CREDENTIALS, server[:password])
    h.put(JMXConnectorFactory::PROTOCOL_PROVIDER_PACKAGES, "weblogic.management.remote")
    h.put("jmx.remote.x.request.waiting.timeout", (5000));
    @connector = JMXConnectorFactory.connect(@service_url, h)
    begin 
      @connection = @connector.getMBeanServerConnection()
    rescue => error
      return error.inspect
    end
  end

  def getattr attribute, property
    @connection.getAttribute(attribute, property)
  end

  def server_list
     @connection.getAttribute(@service, "ServerRuntimes")
  end
end



