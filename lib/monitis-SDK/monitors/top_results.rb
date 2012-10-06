# == Get top results for monitors
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class TopResults < MonitisClient

  # Top results for external monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def external(options={})
    get('topexternal', options)
  end

  # Top results for CPU monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def cpu(options={})
    get('topcpu', options)
  end

  # Top results for Drive monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def drive(options={})
    get('topdrive', options)
  end

  # Top results for Memory monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def memory(options={})
    get('topmemory', options)
  end

  # Top results for Load Average monitor for 1 minute load average
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def load1(options={})
    get('topload1', options)
  end

  # Top results for Load Average monitor for 5 minute load average
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def load5(options={})
    get('topload5', options)
  end

  # Top results for Load Average monitor for 15 minute load average
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def load15(options={})
    get('topload15', options)
  end

  # Top results for Internal HTTP monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def http(options={})
    get('topInternalHTTP', options)
  end

  # Top results for Internal Ping monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def ping(options={})
    get('topInternalPing', options)
  end

  # Top results for Transaction monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def transaction(options={})
    get('topTransaction', options)
  end

  # Top results for Full Page Load monitors
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def fullpage(options={})
    get('topFullpage', options)
  end

  # Top results for Process monitors by CPU usage
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def process_cpu(options={})
    get('topProcessByCPUUsage', options)
  end

  # Top results for Process monitors by memory usage
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def process_memory(options={})
    get('topProcessByMemoryUsage', options)
  end

  # Top results for Process monitors by virtual memory usage
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, used to show results in the
  #   timezone of the user
  # * limit - max number of top results to get
  # * tag - tag to get top results for
  # * detailedResults - default value is false. If value is true then
  #   response will contain additional result fields
  def process_virt_memory(options={})
    get('topProcessByVirtMemoryUsage', options)
  end

end
