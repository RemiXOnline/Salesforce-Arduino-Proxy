require 'xsd/qname'

# {urn:sobject.enterprise.soap.sforce.com}sObject
#   fieldsToNull - SOAP::SOAPString
#   id - (any)
class SObject
  attr_accessor :fieldsToNull
  attr_accessor :id

  def initialize(fieldsToNull = [], id = nil)
    @fieldsToNull = fieldsToNull
    @id = id
  end
end

# {urn:sobject.enterprise.soap.sforce.com}AggregateResult
#   fieldsToNull - SOAP::SOAPString
#   id - (any)
class AggregateResult < SObject
  attr_accessor :fieldsToNull
  attr_accessor :id
  attr_reader :__xmlele_any

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(fieldsToNull = [], id = nil)
    @fieldsToNull = fieldsToNull
    @id = id
    @__xmlele_any = nil
  end
end

# {urn:sobject.enterprise.soap.sforce.com}Arduino_Feed__c
#   fieldsToNull - SOAP::SOAPString
#   id - (any)
#   createdById - (any)
#   feedId__c - SOAP::SOAPString
#   text__c - SOAP::SOAPString
class Arduino_Feed__c < SObject
  attr_accessor :fieldsToNull
  attr_accessor :id
  attr_accessor :createdById
  attr_accessor :feedId__c
  attr_accessor :text__c

  def initialize(fieldsToNull = [], id = nil, createdById = nil, feedId__c = nil, text__c = nil)
    @fieldsToNull = fieldsToNull
    @id = id
    @createdById = createdById
    @feedId__c = feedId__c
    @text__c = text__c
  end
end

# {http://soap.sforce.com/2005/09/outbound}Arduino_Feed__cNotification
#   id - (any)
#   sObject - Arduino_Feed__c
class Arduino_Feed__cNotification
  attr_accessor :id
  attr_accessor :sObject

  def initialize(id = nil, sObject = nil)
    @id = id
    @sObject = sObject
  end
end

# {http://soap.sforce.com/2005/09/outbound}notifications
#   organizationId - (any)
#   actionId - (any)
#   sessionId - SOAP::SOAPString
#   enterpriseUrl - SOAP::SOAPString
#   partnerUrl - SOAP::SOAPString
#   notification - Arduino_Feed__cNotification
class Notifications
  attr_accessor :organizationId
  attr_accessor :actionId
  attr_accessor :sessionId
  attr_accessor :enterpriseUrl
  attr_accessor :partnerUrl
  attr_accessor :notification

  def initialize(organizationId = nil, actionId = nil, sessionId = nil, enterpriseUrl = nil, partnerUrl = nil, notification = [])
    @organizationId = organizationId
    @actionId = actionId
    @sessionId = sessionId
    @enterpriseUrl = enterpriseUrl
    @partnerUrl = partnerUrl
    @notification = notification
  end
end

# {http://soap.sforce.com/2005/09/outbound}notificationsResponse
#   ack - SOAP::SOAPBoolean
class NotificationsResponse
  attr_accessor :ack

  def initialize(ack = nil)
    @ack = ack
  end
end
