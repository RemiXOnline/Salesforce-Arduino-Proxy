require 'default.rb'
require 'rxDBcom.rb'
require 'rxUtil.rb'
require 'rxArduino.rb'
require 'rxArduino.rb'
require 'databasedotcom'

class NotificationPort
  # SYNOPSIS
  #   notifications(request)
  #
  # ARGS
  #   request         Notifications - {http://soap.sforce.com/2005/09/outbound}notifications
  #
  # RETURNS
  #   response        NotificationsResponse - {http://soap.sforce.com/2005/09/outbound}notificationsResponse
  #
  def notifications(request)
    Debug.log "-------- NEW REQUEST --------------"
    #p [request]
    feed=request.notification[0].sObject
    cmd=feed.text__c
    Debug.log "Commande = #{feed.text__c}"
    
    $global_request=request
    $global_feed=feed

    # Send Command to Arduino
    arduino=RXarduino.new('172.16.27.100',80);
    if(arduino.server)
      response=arduino.sendCmd cmd
    end

    # Return ACK to OutboundMessage
    ack=NotificationsResponse.new(true)
    return ack
  end
end

