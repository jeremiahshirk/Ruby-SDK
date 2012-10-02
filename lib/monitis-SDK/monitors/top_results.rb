class TopResults < MonitisClient

  def external(options={})
    # returns top results for external monitors
    get('topexternal', options)
  end

  def cpu(options={})
    #returns top results for CPU monitors
    get('topcpu', options)
  end

  def drive(options={})
    # returns top results for Drive monitors
    get('topdrive', options)
  end

  def memory(options={})
    # returns top results for Memory monitors
    get('topmemory', options)
  end

  def load1(options={})
    # returns Load Average monitors' top results for the first check
    get('topload1', options)
  end

  def load5(options={})
    # returns Load Average monitors' top results for the check after 5 minutes
    get('topload5', options)
  end

  def load15(options={})
    # returns Load Average monitors' top results for the check after 15 minutes
    get('topload15', options)
  end

  def http(options={})
    # returns top results for Internal HTTP monitors
    get('topInternalHTTP', options)
  end

  def ping(options={})
    # returns top results for Internal Ping monitors
    get('topInternalPing', options)
  end

  def transaction(options={})
    # returns top results for Transaction monitors
    get('topTransaction', options)
  end

  def fullpage(options={})
    # returns top results for Full Page Load monitors
    get('topFullpage', options)
  end

  def process_cpu(options={})
    # returns top results for Process monitors by CPU usage
    get('topProcessByCPUUsage', options)
  end

  def process_memory(options={})
    # returns top results for Process monitors by memory usage
    get('topProcessByMemoryUsage', options)
  end

  def process_virt_memory(options={})
    # returns top results for Process monitors by virtual memory usage
    get('topProcessByVirtMemoryUsage', options)
  end

end
