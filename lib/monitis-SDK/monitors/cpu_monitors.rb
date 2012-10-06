# Monitor system CPU utilization
class CPUMonitors < InternalMonitors
  include InternalCommon

  # === Provide API method name hints to the InternalCommon module
  def self.monitor_type
    {add: 'CPU', edit: 'CPU', info: 'CPU',
     delete: 'cpu', monitors: 'CPU', results: 'cpu'}
  end

end