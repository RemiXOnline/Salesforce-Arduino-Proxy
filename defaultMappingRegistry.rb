require 'rubygems'
require 'default.rb'
require 'soap/mapping'

module DefaultMappingRegistry
  EncodedRegistry = ::SOAP::Mapping::EncodedRegistry.new
  LiteralRegistry = ::SOAP::Mapping::LiteralRegistry.new
  NsOutbound = "http://soap.sforce.com/2005/09/outbound"
  NsSobjectEnterpriseSoapSforceCom = "urn:sobject.enterprise.soap.sforce.com"
  NsXMLSchema = "http://www.w3.org/2001/XMLSchema"

  EncodedRegistry.register(
    :class => SObject,
    :schema_type => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "sObject"),
    :schema_element => [
      ["fieldsToNull", "SOAP::SOAPString[]", [0, nil]],
      ["id", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Id")]]
    ]
  )

  EncodedRegistry.register(
    :class => AggregateResult,
    :schema_type => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "AggregateResult"),
    :schema_basetype => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "sObject"),
    :schema_element => [
      ["fieldsToNull", "SOAP::SOAPString[]", [0, nil]],
      ["id", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Id")]],
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  EncodedRegistry.register(
    :class => Arduino_Feed__c,
    :schema_type => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Arduino_Feed__c"),
    :schema_basetype => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "sObject"),
    :schema_element => [
      ["fieldsToNull", "SOAP::SOAPString[]", [0, nil]],
      ["id", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Id")]],
      ["createdById", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "CreatedById")], [0, 1]],
      ["feedId__c", ["SOAP::SOAPString", XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "FeedId__c")], [0, 1]],
      ["text__c", ["SOAP::SOAPString", XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Text__c")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => Arduino_Feed__cNotification,
    :schema_type => XSD::QName.new(NsOutbound, "Arduino_Feed__cNotification"),
    :schema_element => [
      ["id", [nil, XSD::QName.new(NsOutbound, "Id")]],
      ["sObject", "Arduino_Feed__c"]
    ]
  )

  LiteralRegistry.register(
    :class => SObject,
    :schema_type => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "sObject"),
    :schema_element => [
      ["fieldsToNull", "SOAP::SOAPString[]", [0, nil]],
      ["id", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Id")]]
    ]
  )

  LiteralRegistry.register(
    :class => AggregateResult,
    :schema_type => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "AggregateResult"),
    :schema_basetype => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "sObject"),
    :schema_element => [
      ["fieldsToNull", "SOAP::SOAPString[]", [0, nil]],
      ["id", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Id")]],
      ["any", [nil, XSD::QName.new(NsXMLSchema, "anyType")]]
    ]
  )

  LiteralRegistry.register(
    :class => Arduino_Feed__c,
    :schema_type => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Arduino_Feed__c"),
    :schema_basetype => XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "sObject"),
    :schema_element => [
      ["fieldsToNull", "SOAP::SOAPString[]", [0, nil]],
      ["id", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Id")]],
      ["createdById", [nil, XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "CreatedById")], [0, 1]],
      ["feedId__c", ["SOAP::SOAPString", XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "FeedId__c")], [0, 1]],
      ["text__c", ["SOAP::SOAPString", XSD::QName.new(NsSobjectEnterpriseSoapSforceCom, "Text__c")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => Arduino_Feed__cNotification,
    :schema_type => XSD::QName.new(NsOutbound, "Arduino_Feed__cNotification"),
    :schema_element => [
      ["id", [nil, XSD::QName.new(NsOutbound, "Id")]],
      ["sObject", "Arduino_Feed__c"]
    ]
  )

  LiteralRegistry.register(
    :class => Notifications,
    :schema_name => XSD::QName.new(NsOutbound, "notifications"),
    :schema_element => [
      ["organizationId", [nil, XSD::QName.new(NsOutbound, "OrganizationId")]],
      ["actionId", [nil, XSD::QName.new(NsOutbound, "ActionId")]],
      ["sessionId", ["SOAP::SOAPString", XSD::QName.new(NsOutbound, "SessionId")]],
      ["enterpriseUrl", ["SOAP::SOAPString", XSD::QName.new(NsOutbound, "EnterpriseUrl")]],
      ["partnerUrl", ["SOAP::SOAPString", XSD::QName.new(NsOutbound, "PartnerUrl")]],
      ["notification", ["Arduino_Feed__cNotification[]", XSD::QName.new(NsOutbound, "Notification")], [1, 100]]
    ]
  )

  LiteralRegistry.register(
    :class => NotificationsResponse,
    :schema_name => XSD::QName.new(NsOutbound, "notificationsResponse"),
    :schema_element => [
      ["ack", ["SOAP::SOAPBoolean", XSD::QName.new(NsOutbound, "Ack")]]
    ]
  )
end
