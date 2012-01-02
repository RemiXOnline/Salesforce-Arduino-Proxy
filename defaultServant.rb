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
    begin
    Debug.log "-------- NEW REQUEST --------------"
    #p [request]
    feed=request.notification[0].sObject
    cmd=feed.text__c
    Debug.log "Commande = #{cmd}"
    
    $request, $feed =request, feed

    if cmd.upcase=="WAKE UP"
      # Read PlayList
      $dbcom=RXdbcom.new($request.sessionId, $request.enterpriseUrl)
      if $dbcom.client
        $songs=$dbcom.readSongs 
      end
      $index=0
      Debug.log "Playlist : #{$songs.inspect}"
      # Send Command to Arduino PMP3#{$song[$index]}
      arduino=RXarduino.new(ARDUINO[:IP],ARDUINO[:PORT]);
      if arduino.server
        response=arduino.sendCmd "PMP3#{$songs[$index]}"
        # Post "Now Playing ..." To Chatter
        $dbcom.postToChatter($feed.ownerId, "Now playing '#{$songs[$index]}'")
      end
    end
    
    rescue =>ex 
      Debug.log "UNEXPECTED EXCEPTION => #{ex.class} : #{ex.message}"  
    ensure
      # Return ACK to OutboundMessage
      Debug.log "Send ACK to salesforce"
      ack=NotificationsResponse.new(true)
      return ack
     end
  end
end

