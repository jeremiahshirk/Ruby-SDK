class DriveMonitors < InternalMonitors
  include InternalCommon

  def self.monitor_type
    {add: 'Drive', edit: 'Drive', info: 'drive',
     delete: 'drive', monitors: 'Drives', results: 'drive'}
  end

end