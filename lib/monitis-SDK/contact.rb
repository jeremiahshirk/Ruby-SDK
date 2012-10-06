# == Manage contacts
# 
# Methods that take an options argument expect a Hash. The keys are the 
# optional  parameters, documented at http://www.monitis.com/api/api.html
class Contact < MonitisClient

  # Add a new contact
  #
  # === Required arguments
  # * first - first name
  # * last - last name
  # * account - depending on contact type specifies actual account
  #   information: 
  #   email address for mail contact,
  #   phone number for SMS, Phone Call and SMS and Call,
  #   account identifiers for ICQ, Google and Twitter,
  #   URL callback for URL.
  # * type - Contact type, set to:
  #   1 - for Email contact,
  #   2 - for SMS contact,
  #   3 - ICQ,
  #   7 - Google,
  #   8 - Twitter,
  #   9 - Phone Call,
  #   10 - SMS and Call,
  #   11 - URL
  # * timezone - timezone offset from GMT in minutes
  # === Optional arguments
  # * group - the group to which contact will be added. A new group will be
  #   created if a group with such name doesn’t exist
  # * sendDailyReport - set to "true" to enable daily reports
  # * sendWeeklyReport - set to "true" to enable weekly reports
  # * sendMonthlyReport - set to "true" to enable monthly reports
  # * portable - is available only for "SMS" and "SMS and Call" contact types.
  #   "true" if mobile number was moved from one operator to another under the
  #   'number portability' system
  # * country - full name, 2 or 3 letter codes for the country.
  #   E.g. United States, US or USA
  # * textType - could be "true" to get plain text alerts or "false" to get
  #   HTML formatted alerts
  def add_contact(first, last, account, type, timezone, options={})
    args = {firstName: first, lastName: last, account: account,
            contactType: type, timezone: timezone}.merge(options)
    post('addContact', args)
  end

  # Delete a contact
  #
  # === Required arguments
  # * contact_id - ID of the contact to delete
  # * account - account information depending on contact type: 
  #   email address for mail contact,
  #   phone number for SMS, Phone Call and SMS and Call,
  #   account identifiers for ICQ, Google and Twitter,
  #   URL callback for URL.
  # * type - Contact type, set to:
  #   1 - for Email contact,
  #   2 - for SMS contact,
  #   3 - ICQ,
  #   7 - Google,
  #   8 - Twitter,
  #   9 - Phone Call,
  #   10 - SMS and Call,
  #   11 - URL
  def delete_contact(*args)
    if args.length == 1
      result = post('deleteContact', contactId: args.first)
    elsif args.length == 2
      result = post('deleteContact', account: args[0], contactType: args[1])
    else
      raise "delete contact takes 1 or 2 args"
    end
    result
  end

  # Edit a contact
  #
  # === Required arguments
  # * contact_id - ID of the contact to edit
  #
  # === Optional arguments
  # * firstName
  # * lastName
  # * account - depending on contact type specifies actual account
  #   information: 
  #   email address for mail contact,
  #   phone number for SMS, Phone Call and SMS and Call,
  #   account identifiers for ICQ, Google and Twitter,
  #   URL callback for URL.
  # * contactType - Contact type, set to:
  #   1 - for Email contact,
  #   2 - for SMS contact,
  #   3 - ICQ,
  #   7 - Google,
  #   8 - Twitter,
  #   9 - Phone Call,
  #   10 - SMS and Call,
  #   11 - URL
  # * timezone - timezone offset from GMT in minutes
  # === Optional arguments
  # * group - the group to which contact will be added. A new group will be
  #   created if a group with such name doesn’t exist
  # * portable - is available only for "SMS" and "SMS and Call" contact types.
  #   "true" if mobile number was moved from one operator to another under the
  #   'number portability' system
  # * country - full name, 2 or 3 letter codes for the country.
  #   E.g. United States, US or USA
  # * textType - could be "true" to get plain text alerts or "false" to get
  #   HTML formatted alerts
  def  edit_contact(id, options={})
    args = {contactId: id}.merge(options)
    post('editContact', args)
  end

  # Confirm a contact
  #
  # === Required arguments
  # * id - contact ID
  # * confirmation_key - confirmation key of the contact
  def confirm_contact(id, confirmation_key)
    post('confirmContact', contactId: id, confirmationKey: confirmation_key)
  end

  # Activate a contact
  #
  # === Required arguments
  # * contact_id - ID of the contact to activate
  def activate_contact(contact_id)
    post('contactActivate', contactId: contact_id)
  end

  # Deactivate a contact
  #
  # === Required arguments
  # * contact_id - ID of the contact to deactivate
  def deactivate_contact(contact_id)
    post('contactDeactivate', contactId: contact_id)
  end

  # Get all groups of contacts for the user
  def contact_groups()
    get('contactGroupList')
  end

  # Get all contacts for the user
  def contacts()
    get('contactsList')
  end

  # Get recent alerts history
  #
  # === Required arguments
  #
  # === Optional arguments
  # * timezone - offset relative to GMT, used to retrieve results in the
  #   given timezone. The default value is 0
  # * startDate - start date to get results for
  # * endDate - end date to get results for
  # * limit - maximum number of alerts to get
  def recent_alerts(options={})
    get('recentAlerts', options)
  end
      
end