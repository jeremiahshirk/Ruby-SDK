# == Implement methods common to internal monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
module InternalCommon

  # Get information for the specified monitor
  #
  # === Required arguments
  # * monitor_id
  def info(monitor_id)
    api_name = self.class.monitor_type[:info]
    get("#{api_name}Info", monitorId: monitor_id)
  end

  # List the existing monitors for the given agent
  #
  # === Required arguments
  # * agent_id
  def monitors(agent_id)
    api_name = self.class.monitor_type[:monitors]
    get("agent#{api_name}", agentId: agent_id)
  end

  # Delete the specified monitor
  #
  # === Required arguments
  # * monitor_id
  def delete(monitor_id)
    api_name = self.class.monitor_type[:delete]
    super(monitor_id, api_name.to_sym)
  end

  # Add a new monitor
  #
  # === Required arguments
  # * key
  # * name
  # * tag
  #
  # Additional parameters will vary depending on the type of monitor.
  # See the specific documentation at http://www.monitis.com/api/api.html
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

  # Edit an existing monitor
  #
  # === Required arguments
  # * test_id
  # * name
  # * tag
  #
  # Additional parameters will vary depending on the type of monitor.
  # See the specific documentation at http://www.monitis.com/api/api.html
  def edit(test_id, name, tag, options={})
    api_name = self.class.monitor_type[:edit]
    args = {testId: test_id, name: name, tag: tag}.merge(options)
    post("edit#{api_name}Monitor", args)
  end

  # Get results for an existing monitor
  #
  # === Required arguments
  # * monitor_id
  # * year
  # * month
  # * day
  #
  # === Optional arguments
  # * timezone - offset relative to GMT, in minutes, 
  #   used to show results in the timezone of the user
  def results(monitor_id, year, month, day, options={})
    api_name = self.class.monitor_type[:results]
    args = {monitorId: monitor_id, day: day, month: month,
            year: year}.merge(options)
    get("#{api_name}Result", args)
  end

end