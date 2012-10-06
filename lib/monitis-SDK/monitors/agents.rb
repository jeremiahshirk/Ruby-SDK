require 'net/http'

# == Manage agents for internal monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class Agents < MonitisClient 

  # Get all of the user's agents
  #
  # === Optional arguments
  # * keyRegExp - key of the agents to include in the results 
  #   list represented as a Java RegEx
  def agents
    get('agents')
  end

  # Get information for the specified agent
  #
  # === Optional arguments
  # * loadTests - if true response will contain information about tests of 
  #   this agent. The default value is false.
  def info(agent_id, options={})
    args = {agentId: agent_id}.merge(options)
    get('agentInfo', args)
  end

  # Get snapshot for the specified agent
  #
  # === Required arguments
  # One of agentKey or platform is required
  # * agentKey - key of the agent to get snapshot for
  # * platform - platform of the agents to get snapshot for 
  #   (possible values are "LINUX", "WINDOWS", "OPENSOLARIS", "MAC", "FREEBSD")
  # === Optional arguments
  # * timezone - offset relative to GMT in minutes
  # * tag - if platform is included
  def snapshot(options={})
    # vary based on args, choose allAgentsSnapshot or agentSnapshot
    if options.has_key? :platform
      result = get('allAgentsSnapshot', platform: options[:platform])
    elsif options.has_key? :agentKey
      result = get('agentSnapshot', agentKey: options[:agentKey])
    else
      raise "snapshot requires platform or agentKey"
    end
    result
  end

  # Delete the specified agent
  #
  # === Arguments
  # One of the following arguments is required
  # * agentIds - comma separated ids of the agents to remove
  # * keyRegExp - key of the agents to remove represented as a Java RegEx
  def delete(options={})
    # vary based on args, either agentIds[] or keyRegExp
    if options.class == Hash
      args = options
    else
      # treat it as the agent id(s)
      options = options.join(',') if options.class == Array
      args = {agentIds: options}
    end
    post('deleteAgents', args)
  end

  # Download an agent for the specified platform
  #
  # === Required arguments
  # * platform - One of linux32, linux64, win32, Sun8632, FBSD32, FBSD64
  def download(platform)
    post_raw('downloadAgent', platform: platform)
  end
  
end