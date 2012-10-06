# Monitor file system volumes
class DriveMonitors < InternalMonitors
  include InternalCommon

  # === Provide API method name hints to the InternalCommon module
  def self.monitor_type
    {add: 'Drive', edit: 'Drive', info: 'drive',
     delete: 'drive', monitors: 'Drives', results: 'drive'}
  end

end