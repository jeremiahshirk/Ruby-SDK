# Monitor remote systems with HTTP requests
class HTTPMonitors < InternalMonitors
  include InternalCommon
  
  # === Provide API method name hints to the InternalCommon module
  def self.monitor_type
    {add: 'InternalHttp', edit: 'InternalHttp', info: 'internalHttp',
     delete: 'agentHttpTest', monitors: 'HttpTests', results: 'internalHttp',
     agentkey_name: 'userAgentId'}
  end
   
end