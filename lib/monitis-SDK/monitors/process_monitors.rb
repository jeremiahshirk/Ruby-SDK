# Monitor system processes
class ProcessMonitors < InternalMonitors
  include InternalCommon
  
  # === Provide API method name hints to the InternalCommon module
  def self.monitor_type
    {add: 'Process', edit: 'Process', info: 'process',
     delete: 'process', monitors: 'Processes', results: 'process'}
  end
    
end