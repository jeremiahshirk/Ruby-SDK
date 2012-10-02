class CustomAgent < MonitisClient

  def initialize(options={})
    options[:use_custom_monitor] = true
    super(options)
  end

  def add(name, options={})
  	args = {name: name}.merge(options)
  	addAgent(args)
  end

  def add_job(id, type, interval, params, options={})
  	args = {agentId: id, type: type, interval: interval,
  		      params: params}.merge(options)
  	addJob(args)
  end

  def edit(id, name, options={})
  	args = {agentId: id, name: name}.merge(options)
  	editAgent(args)
  end

  def edit_job(id, options={})
  	args = {jobId: id}.merge(options)
  	editJob(args)
  end

  def delete(ids, options={})
  	ids = ids.join(',') if ids.class == Array
  	args = {agentIds: ids}.merge(options)
  	deleteAgent(args)
  end

  def delete_job(ids, options={})
  	ids = ids.join(',') if ids.class == Array
  	args = {jobIds: ids}.merge(options)
  	deleteJob(args)
  end

  def agents(options={})
  	getAgents(options)
  end

  def jobs(agent_id, options={})
  	args = {agentId: agent_id}.merge(options)
  	getJobs(args)
  end

  def info(id, options={})
  	args = {agentId: id}.merge(options)
  	agentInfo(args)
  end

end