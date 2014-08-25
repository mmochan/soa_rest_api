class ConnectionFactory

  def initialize
    super
  end

  def attrs
    data[:jms][:resources][name]['ConnectionFactories'][fname][:attrs] = {}
    
  end

end
