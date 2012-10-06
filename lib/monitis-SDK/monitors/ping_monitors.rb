# Monitor remote systems with ping
class PingMonitors < InternalMonitors
  include InternalCommon
  
  # === Provide API method name hints to the InternalCommon module
  def self.monitor_type
    {add: 'InternalPing', edit: 'InternalPing', info: 'internalPing',
     delete: 'agentPingTest', monitors: 'PingTests', results: 'internalPing',
     agentkey_name: 'userAgentId'}
  end

end