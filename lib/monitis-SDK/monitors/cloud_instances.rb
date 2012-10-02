class CloudInstances < MonitisClient

  def instances(options={})
    get('cloudInstances', options)
  end

  def info(type, instance_id, options={})
    args = {type: type, instanceId: instance_id}.merge(options)
    get('cloudInstanceInfo', args)
  end

end