# == Manage agents for custom monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class CustomAgent < MonitisClient

  # Create a new CustomAgent manager
  def initialize(options={})
    options[:use_custom_monitor] = true
    super(options)
  end

  # Add a new custom agent
  #
  # === Required arguments
  # * name - name of the custom agent
  #
  # === Optional arguments
  # * params - Valid json string to store agent params 
  #   {param1:value1, param2:value2, ...}
  def add(name, options={})
  	args = {name: name}.merge(options)
  	post('addAgent', args)
  end

  # Add a custom agent job
  #
  # === Required arguments
  # * agent_id - ID of the agent to add a job for
  # * type - type of the job
  # * interval - interval (minutes) with which job must be executed
  # * params - JSON string with describing job params {key:value1, ke2:value1, ..}
  #
  # === Optional arguments
  # * monitorId - If job has some relations with specific monitor, this 
  #   param should contain id of that monitor
  def add_job(id, type, interval, params, options={})
  	args = {agentId: id, type: type, interval: interval,
  		      params: params}.merge(options)
  	post('addJob', args)
  end

  # Edit an existing custom agent
  #
  # === Required arguments
  # * agent_id - ID of the agent to edit
  # * name - name of the agent
  #
  # === Optional arguments
  # * params - JSON string with describing job params {key:value1, ke2:value1, ..}
  def edit(id, name, options={})
  	args = {agentId: id, name: name}.merge(options)
  	post('editAgent', args)
  end

  # Edit existing custom agent job
  #
  # === Required arguments
  # * job_id - ID of the job to edit
  #
  # === Optional arguments
  # * type - type of the job
  # * interval - interval (minutes) with which job must be executed
  # * params - JSON string with describing job params {key:value1, ke2:value1, ..}
  def edit_job(id, options={})
  	args = {jobId: id}.merge(options)
  	post('editJob', args)
  end

  # Delete custom agents
  #
  # === Required arguments
  # * agent_ids - comma separated list of IDs of agents to delete
  #
  # === Optional arguments
  # * deleteMonitors - set to false if you don't want to delete monitors
  #   added for those agents. Default value is true
  def delete(ids, options={})
  	ids = ids.join(',') if ids.class == Array
  	args = {agentIds: ids}.merge(options)
  	post('deleteAgent', args)
  end

  # Delete custom agent jobs
  #
  # === Required arguments
  # * job_ids - comma separated list of IDs of jobs to delete
  def delete_job(ids, options={})
  	ids = ids.join(',') if ids.class == Array
  	args = {jobIds: ids}.merge(options)
  	post('deleteJob', args)
  end

  # Get list of custom agents
  #
  # === Optional arguments
  # * loadTests - if true response will contain information about tests of
  #   this agent. The default value is false.
  # * type - limit response to agents of this type
  def agents(options={})
  	get('getAgents', options)
  end

  # Get the jobs for the specified agent
  #
  # === Required arguments
  # * agent_id - ID of the agent to get jobs for
  #
  # === Optional arguments
  # * lastJobId - minimum id of jobs to be retrived
  def jobs(agent_id, options={})
  	args = {agentId: agent_id}.merge(options)
  	get('getJobs', args)
  end

  # Get info for the specified agent
  #
  # === Required arguments
  # * agent_id - ID of the agent to get info for
  def info(id, options={})
  	args = {agentId: id}.merge(options)
  	get('agentInfo', args)
  end

end