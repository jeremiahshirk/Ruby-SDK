class ProcessMonitors < InternalMonitors
  include InternalCommon
  
  def self.monitor_type
    {add: 'Process', edit: 'Process', info: 'process',
     delete: 'process', monitors: 'Processes', results: 'process'}
  end
    
end