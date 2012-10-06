# == Manage cloud instances
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class CloudInstances < MonitisClient

  # Get all of the user's cloud instances
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in
  #   the timezone of the user
  def instances(options={})
    get('cloudInstances', options)
  end

  # Get information regarding the specified Cloud Instance
  #
  # === Required arguments
  # * type - type of the cloud instance. Possible values are "ec2", "rackspace", "gogrid"
  # * instance_id - id of the cloud instance in Monitis
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in
  #   the timezone of the user
  def info(type, instance_id, options={})
    args = {type: type, instanceId: instance_id}.merge(options)
    get('cloudInstanceInfo', args)
  end

end