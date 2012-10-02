class InternalMonitors < MonitisClient

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

  def delete(test_ids, type)
    type = @type_map.fetch(type) if type.class == Symbol
    test_ids = test_ids.join(',') if test_ids.class == Array
    args = {testIds: test_ids, type: type}
    deleteInternalMonitors(args)
  end

  def monitors(options={})
    internalMonitors(options)
  end

end  