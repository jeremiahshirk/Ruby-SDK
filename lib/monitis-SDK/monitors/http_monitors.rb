class HTTPMonitors < InternalMonitors
  include InternalCommon
  
  def self.monitor_type
    {add: 'InternalHttp', edit: 'InternalHttp', info: 'internalHttp',
     delete: 'agentHttpTest', monitors: 'HttpTests', results: 'internalHttp',
     agentkey_name: 'userAgentId'}
  end
   
end