# Monitor system memory
class MemoryMonitors < InternalMonitors
  include InternalCommon

  # === Provide API method name hints to the InternalCommon module
  def self.monitor_type
    {add: 'Memory', edit: 'Memory', info: 'memory',
     delete: 'memory', monitors: 'Memory', results: 'memory'}
  end

end