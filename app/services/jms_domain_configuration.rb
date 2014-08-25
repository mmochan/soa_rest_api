class JmsDomainConfiguration < MbeanConnection

  attr_accessor :data

  def initialize(server)
    @data = {:jms =>{}}
    super(server)
  end

  def connection_factories name,  jms_resource
    data[:jms][:resources][name]['ConnectionFactories'] = {}
    connection_factories = getattr(jms_resource, 'ConnectionFactories')
    connection_factories.each do |factory|
     fname = getattr(factory, "Name")
     data[:jms][:resources][name]['ConnectionFactories'][fname] = {}
     data[:jms][:resources][name]['ConnectionFactories'][fname]['attrs'] = "Testing"
     ConnectionFactory.new
    end
  end

  def distributed_topics name, jms_resource
    data[:jms][:resources][name]['DistributedTopics'] = {}
    distributed_topics = getattr(jms_resource, 'DistributedTopics')
    distributed_topics.each do |topic|
      tname = getattr(topic, "Name")
      data[:jms][:resources][name]['DistributedTopics'][tname] = {}
    end
  end

  def distributed_queues name, jms_resource
    data[:jms][:resources][name]['DistributedQueues'] = {}
    distributed_queues = getattr(jms_resource, 'DistributedQueues')
    distributed_queues.each do |queue|
      qname = getattr(queue, "Name")
      data[:jms][:resources][name]['DistributedQueues'][qname] = qname
    end
  end

  def topics name, jms_resource
    data[:jms][:resources][name]['Topics'] = {}
    topics = getattr(jms_resource, 'Topics')
    topics.each do |topic|
      tname = getattr(topic, "Name")
      data[:jms][:resources][name]['Topics'][tname] = {}
    end
  end

  def uniformed_distributed_queues name, jms_resource
    data[:jms][:resources][name]['UniformDistributedQueues'] = {}
    queues = getattr(jms_resource, 'UniformDistributedQueues')
    queues.each do |queue|
      queue = getattr(queue, "Name")
      data[:jms][:resources][name]['UniformDistributedQueues'][queue] = {}
    end
  end

  def uniformed_distributed_topics name, jms_resource
    data[:jms][:resources][name]['UniformDistributedTopics'] = {}
    topics = getattr(jms_resource, 'UniformDistributedTopics')
    topics.each do |topic|
      topic = getattr(topic, "Name")
      data[:jms][:resources][name]['UniformDistributedTopics'][topic] = {}
    end
  end

  def jms_configuration 
    data[:jms][:resources] = {}
    data[:jms][:servers] = {}

    domain = getattr(@service, "DomainConfiguration")
    #JMS System Resources
    jmsresources = getattr(domain, "JMSSystemResources") 
    jmsresources.each do |resource|
      name = getattr(resource, "Name")   
      data[:jms][:resources][name] = {}
      jms_resource = getattr(resource, "JMSResource")

      connection_factories(name, jms_resource)
      distributed_queues name, jms_resource
      distributed_topics name, jms_resource
      topics name, jms_resource
      uniformed_distributed_queues name, jms_resource
      uniformed_distributed_topics name, jms_resource
    end   
    #JMS Servers
    jms_servers = getattr(domain, 'JMSServers')
    jms_servers.each do |server|
      name = getattr(server, "Name")   
      data[:jms][:servers][name] = {}
      #data = getattr(server, "JMSServers")
    end
    data
  end
end
