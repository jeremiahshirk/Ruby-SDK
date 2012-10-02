module InternalCommon

  def info(monitor_id)
    api_name = self.class.monitor_type[:info]
    get("#{api_name}Info", monitorId: monitor_id)
  end

  def monitors(agent_id)
    api_name = self.class.monitor_type[:monitors]
    get("agent#{api_name}", agentId: agent_id)
  end

  def delete(monitor_id)
    api_name = self.class.monitor_type[:delete]
    super(monitor_id, api_name.to_sym)
  end

  def add(key, name, tag, options={})
    api_name = self.class.monitor_type[:add]
    agentkey_name = self.class.monitor_type.fetch(:agentkey_name, nil)
    if (agentkey_name)
      args = {agentkey_name.to_sym => key, name: name, tag: tag}.merge(options)
    else
      args = {agentkey: key, name: name, tag: tag}.merge(options)
    end
    post("add#{api_name}Monitor", args)
  end

  def edit(id, name, tag, options={})
    api_name = self.class.monitor_type[:edit]
    args = {testId: id, name: name, tag: tag}.merge(options)
    post("edit#{api_name}Monitor", args)
  end

  def results(monitor_id, day, month, year, options={})
    api_name = self.class.monitor_type[:results]
    args = {monitorId: monitor_id, day: day, month: month,
            year: year}.merge(options)
    get("#{api_name}Result", args)
  end

end