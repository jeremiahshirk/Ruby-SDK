class LoadAverageMonitors < InternalMonitors
  include InternalCommon
  
  def self.monitor_type
    {add: 'LoadAverage', edit: 'LoadAverage', info: 'loadAvg',
     delete: 'load', monitors: 'LoadAvg', results: 'loadAvg'}
  end
   
end