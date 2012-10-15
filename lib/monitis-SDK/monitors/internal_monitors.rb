# == Manage common methods for internal monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class InternalMonitors < MonitisClient

  # Create new internal monitor manager
  #
  # === Required arguments
  #
  # === Optional arguments
  def initialize(options={})
    @type_map = { 
                  process: 1,
                  drive: 2,
                  memory: 3, 
                  agentHttpTest: 4,
                  agentPingTest: 5,
                  load: 6,
                  cpu: 7
                }
    super(options)
  end

  # Delete an internal monitor
  #
  # === Required arguments
  # * test_ids - comma separated ids of the internal tests to delete
  # * type - type of the internal monitor.  See 
  #   http://www.monitis.com/api/api.html#deleteInternalMonitors for
  #   values for type
  #
  # === Optional arguments
  def delete(test_ids, type)
    type = @type_map.fetch(type) if type.class == Symbol
    test_ids = test_ids.join(',') if test_ids.class == Array
    args = {testIds: test_ids, type: type}
    post('deleteInternalMonitors', args)
  end

end  