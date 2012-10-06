# == Implement methods to manage visitor trackers
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class VisitorTrackerMonitors < MonitisClient

  # Get results for a specified site
  #
  # === Required arguments
  # * site_id
  # * year
  # * month
  # * day
  #
  # === Optional arguments
  # * timezoneoffset - offset relative to GMT, in minutes, 
  #   used to show results in the timezone of the user
  def results(site_id, year, month, day, options={})
    args = {siteId: site_id, year: year, month: month, day:day}.merge(options)
    get('visitorTrackingResults', args)
  end

  # Get info for a full page load monitor
  #
  # === Required arguments
  # * site_id - ID of the monitor to get information for
  def info(site_id)
    get('visitorTrackingInfo', {siteId: site_id})
  end

  # Get a list of visitor trackers
  def monitors
    get('visitorTrackingTests')
  end

  # Get a list of sites from all visitor trackers
  def sites
    get('visitorTrackingTests').collect {|x| x[0]}
  end

end