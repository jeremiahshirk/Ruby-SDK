# == Manage notifications
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class Notification < MonitisClient

  # Add a notification rule
  #
  # === Required arguments
  # * id - Contact ID to receive notifications
  # * type - Monitor type.  Valid values are:
  #   external,
  #   transaction,
  #   fullPageLoad,
  #   cpu,
  #   load,
  #   memory,
  #   drive,
  #   process,
  #   agentPingTest,
  #   agentHttpTest,
  #   custom
  # * period - specifies the period when notifications wll be active.
  #   Valid values are: 
  #   always - active always, 
  #   specifiedTime - active every day on specified time interval, 
  #   specifiedDays - active on specified day and time period.
  # * notify_backup - valid values are 0 and 1. Specify 1, if you want to
  #   receive notification when monitor recovers. Otherwise specify 0
  # * continuous_alerts - valid values are 0 and 1. Specify 1, if you want 
  #   notifications to be sent for all failures until the monitor recovers.
  #   Specify 0, if you want to receive notification once
  # * failure_count - number of faulires needed to trigger the notification
  # * comparing_method - Indicates how the paramValue must be compared.
  #   Valid values are: equals, greater, or less
  #
  # === Optional arguments
  # * weekdayFrom - indicates starting week day for notifications. Must be 
  #   specified in case parameter period has the value specifiedDays. Valid
  #   values are 1..7. (For Sunday - 1, for Monday-2,..., for Saturday-7).
  # * weekdayTo - indicates starting week day for notifications. Must be 
  #   specified in case parameter period has the value specifiedDays. Valid
  #   values are 1..7. (For Sunday - 1, for Monday-2,..., for Saturday-7).
  # * timeFrom - indicates staring time for notifications. Must be specified
  #   in case parameter period has the value specifiedDays or specifiedTime.
  #   Valid format is hh:mm:ss
  # * timeTo - indicates staring time for notifications. Must be specified
  #   in case parameter period has the value specifiedDays or specifiedTime.
  #   Valid format is hh:mm:ss
  # * contactGroup - name of the contact group. The notification rule will be
  #   added to all contacts in the group. This field is mandatory if the
  #   parameter contactId is missing.
  # * contactId - id of the contact. This field is mandatory if the parameter
  #   contactGroup is missing
  # * minFailedLocationCount - used for external, fullPageLoad and transaction
  #   monitor types. Indicates minimum number of failed locations needed to
  #   trigger the notification. Default value is 1.
  # * paramName - Required for monitorType custom. Indicates the name of a
  #   result parameter the value of which indicates the failure.
  # * paramValue - Required for monitorType custom. The result value needed to
  #   trigger the notification.
  def add_notification_rule(id, type, period, notify_backup, 
                            continuous_alerts, failure_count, 
                            comparing_method, options={})
    args = {
      monitorId: id, monitorType: type, period: period,
      notifyBackup: notify_backup, continuousAlerts: continuous_alerts, 
      failureCount: failure_count, comparingMethod: comparing_method
      }.merge(options)

    addNotificationRule(args)
  end

  # Delete notification rules
  #
  # === Required arguments
  # * contact_ids - comma separated list of contact IDs
  # * monitor_id - id of the monitor for which the rule was defined for
  # * monitor_type - description
  #   external,
  #   transaction,
  #   fullPageLoad,
  #   cpu,
  #   load,
  #   memory,
  #   drive,
  #   process,
  #   agentPingTest,
  #   agentHttpTest,
  #   custom
  def delete_notification_rule(contact_ids, monitor_id, monitor_type)
    contact_ids = contact_ids.join(',') if contact_ids.class == Array
    args = {contactIds: contact_ids, 
            monitorId: monitor_id,
            monitorType: monitor_type}
    deleteNotificationRule(args)
  end

  # Get notification rules
  #
  # === Required arguments
  #
  # === Optional arguments
  # * id - id of the monitor for which the rules were defined
  # * name - description
  # * monitor_type - description
  #   external,
  #   transaction,
  #   fullPageLoad,
  #   cpu,
  #   load,
  #   memory,
  #   drive,
  #   process,
  #   agentPingTest,
  #   agentHttpTest,
  #   custom
  # * contact_id - id of the contact for which the rules were defined
  def notification_rules(id, type)
    getNotificationRules(monitorId: id, monitorType: type)
  end
end