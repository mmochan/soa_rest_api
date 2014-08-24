class JdbcDomainConfiguration < MbeanConnection

  attr_accessor :data

  def initialize(server)
    @data = {:jdbc =>{}}
    #@status = {}
    super(server)
  end

  def driver_params name, jdbc_resource
    data[:jdbc][name]["JDBCDriverParams"] = {}
    driver_params = getattr(jdbc_resource, "JDBCDriverParams")
    data[:jdbc][name]["JDBCDriverParams"] = 
      {:properties => { :DriverName => getattr(driver_params, "DriverName"),
                        #:Password   => getattr(driver_params, "Password" ),  Not allowed to grab the password
                        :Url        => getattr(driver_params, "Url" )}}    
  end

  def data_source_params name, jdbc_resource
    data[:jdbc][name]["JDBCDataSourceParams"] = {}    
    data_source_params = getattr(jdbc_resource, "JDBCDataSourceParams")
    data[:jdbc][name]["JDBCDataSourceParams"] = 
      {:properties => { :AlgorithmType              => getattr(data_source_params, "AlgorithmType"),
                        :DataSourceList             => getattr(data_source_params, "DataSourceList"),
                        :GlobalTransactionsProtocol => getattr(data_source_params, "GlobalTransactionsProtocol"),
                        :JNDINames                  => getattr(data_source_params, "JNDINames").first }}    
  end

  def oracle_params name, jdbc_resource
    data[:jdbc][name]["JDBCOracleParams"] = {}
    oracle_params = getattr(jdbc_resource, "JDBCOracleParams")
    data[:jdbc][name]["JDBCOracleParams"] = 
      {:properties => { :fanEnabled   =>   getattr(oracle_params, "FanEnabled"),
                        :OnsNodeList  =>  getattr(oracle_params, "OnsNodeList").to_s }}    
  end

  def connection_pool_params name, jdbc_resource
    data[:jdbc][name]["JDBCConnectionPoolParams"] = {}    
    pool_params = getattr(jdbc_resource, "JDBCConnectionPoolParams")
    data[:jdbc][name]["JDBCConnectionPoolParams"] = 
      {:properties => { :ConnectionCreationRetryFrequencySeconds => getattr(pool_params, "ConnectionCreationRetryFrequencySeconds"),
                        :InitialCapacity          => getattr(pool_params, "InitialCapacity"),
                        :MinCapacity              => getattr(pool_params, "MinCapacity"),
                        :MaxCapacity              => getattr(pool_params, "MaxCapacity"),
                        :TestConnectionsOnReserve => getattr(pool_params, "TestConnectionsOnReserve"),
                        :TestFrequencySeconds     => getattr(pool_params, "TestFrequencySeconds"),
                        :TestTableName            => getattr(pool_params, "TestTableName"), }}
  end

  def jdbc_configuration 
    domain = getattr(@service, "DomainConfiguration")
    jdbcresources = getattr(domain, "JDBCSystemResources")
    jdbcresources.each  do |resource|
      name = getattr(resource, "Name")
      data[:jdbc][name] = {}
      jdbc_resource = getattr(resource, "JDBCResource")

      driver_params(name, jdbc_resource)
      data_source_params name, jdbc_resource
      oracle_params name, jdbc_resource
      connection_pool_params name, jdbc_resource

    end
    data
  end
end  
