# Monitor system load averages
class LoadAverageMonitors < InternalMonitors
  include InternalCommon
  
  # === Provide API method name hints to the InternalCommon module
  def self.monitor_type
    {add: 'LoadAverage', edit: 'LoadAverage', info: 'loadAvg',
     delete: 'load', monitors: 'LoadAvg', results: 'loadAvg'}
  end
   
end