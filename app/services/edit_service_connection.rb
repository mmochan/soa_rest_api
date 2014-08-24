require "java"

#require_relative "./wlfullclient.jar"

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

class EditServiceConnection < MbeanConnection

  def initialize(server)
    @status = {}
    @server_name = server[:name]
    @protocol = "t3"
    @jndiroot = "/jndi/"
    @mserver = "weblogic.management.mbeanservers.edit"
    @service_url = JMXServiceURL.new(@protocol, server[:adminUrl], server[:port], @jndiroot + @mserver)
    @service = ObjectName.new( "com.bea:Name=EditService,Type=weblogic.management.mbeanservers.edit.EditServiceMBean")

    super(server)

  end

  def status
    { "Message"=> "EditServiceMBean"}
  end  
end
