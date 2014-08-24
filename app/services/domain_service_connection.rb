class DomainServiceConnection < MbeanConnection

  def initialize(server)
    @status = {}
    super(server)
  end

  def server_runtimes
    server_list.each do |server|
      @status[getattr(server, "Name")]  = getattr(server, "State")
      @status["WeblogicHome"]           = getattr(server, "WeblogicHome")
      @status["WeblogicVersion"]        = getattr(server, "WeblogicVersion").split(' ')[2]     
      @status["AdministrationURL"]      = getattr(server, "AdministrationURL")   
      @status["ThreadPoolState"]        = thread_pool_state(server)
      @status["HoggingThreadCount"]     = thread_pool_hogging(server)
      @status["HeapFreePercent"]        = jvm_free(server)    
      @status["datasources"]            = jdbc_runtime(server)    #Keeps getting overwritten
    end
    return @status
  end

  def jdbc_runtime server
    @data = {}
    jdbc_service = getattr(server, "JDBCServiceRuntime")
    datasources = getattr(jdbc_service, "JDBCDataSourceRuntimeMBeans")
    datasources.each do |datasource|
      name = getattr(datasource, "Name")
      @data[name] = {:state => getattr(datasource, "State") }
    end
    return @data
  end

  def thread_pool_state server
    runtime = getattr(server, "ThreadPoolRuntime")
    getattr(runtime, "HealthState").to_s.split(',')[1].split(":")[-1]
  end

  def thread_pool_hogging server
    runtime = getattr(server, "ThreadPoolRuntime")
    getattr(runtime, "HoggingThreadCount")
  end

  def jvm_free server
    runtime = getattr(server, "JVMRuntime")
    getattr(runtime, "HeapFreePercent").to_s
  end

end
