class PingMonitors < InternalMonitors
  include InternalCommon
  
  def self.monitor_type
    {add: 'InternalPing', edit: 'InternalPing', info: 'internalPing',
     delete: 'agentPingTest', monitors: 'PingTests', results: 'internalPing',
     agentkey_name: 'userAgentId'}
  end

end