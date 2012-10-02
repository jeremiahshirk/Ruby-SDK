require 'net/http'

class Agents < MonitisClient 

  # # matches API defaults  
  # def agents()
  # end

  def info(id, options={})
    args = {agentId: id}.merge(options)
    agentInfo(args)
  end

  def snapshot(options)
    # vary based on args, choose allAgentsSnapshot or agentSnapshot
    if options.has_key? :platform
      result = allAgentsSnapshot(platform: options[:platform])
    elsif options.has_key? :agentKey
      result = agentSnapshot(agentKey: options[:agentKey])
    else
      raise "snapshot requires platform or agentKey"
    end
    result
  end

  def delete(options={})
    # vary based on args, either agentIds[] or keyRegExp
    if options.class == Hash
      deleteAgents(options)
    else
      # treat it as the agent id(s)
      options = options.join(',') if options.class == Array
      args = {agentIds: options}
    end
    deleteAgents(args)
  end

  def download(platform)
    post_raw('downloadAgent', platform: platform)
  end
  
end