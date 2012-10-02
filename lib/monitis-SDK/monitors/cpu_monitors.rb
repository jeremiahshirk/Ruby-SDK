class CPUMonitors < InternalMonitors
  include InternalCommon

  def self.monitor_type
    {add: 'CPU', edit: 'CPU', info: 'CPU',
     delete: 'cpu', monitors: 'CPU', results: 'cpu'}
  end

end