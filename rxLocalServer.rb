require 'socket'               # Get sockets from stdlib
require 'rxUtil.rb'
require 'rxArduino.rb'
#####################
# Next Song
#####################
def nextSong
  begin
    if !$index
      $index=0
    else
      $index+=1 
    end
    if $index>=$songs.length
      $index=0
    end
    $songs[$index]
    rescue 
     Debug.log "Don't know the playlist ..."
     "Ringtone.mp3"
  end
end

######################
# Local Server
######################
def localServer
  server = TCPServer.open(LOCAL_PORT)   # Socket to listen on port 2000
  Debug.log "Started - Available for IP connexion on port #{LOCAL_PORT}"
  loop {                          # Servers run forever
    Thread.start(server.accept) do |client|
    begin
    Debug.log "New Connexion"
    client.puts("[#{$0}] >> Connected to Local Server")
    readFromArduino=client.readline.chop
    Debug.log "Cmd from Arduino '#{readFromArduino}'"

    # -----------------------------------
    # Switch Song
    # -----------------------------------
    if readFromArduino.upcase=="SWITCH"
      Debug.log "Do Switch"
      currentSong=nextSong
      # Send Command to Arduino "PMP3#{currentSong}"
      arduino=RXarduino.new(ARDUINO[:IP],ARDUINO[:PORT]);
      if arduino.server
        response=arduino.sendCmd "PMP3#{currentSong}"
        # Post "Now Playing ..." To Chatter
        $dbcom.replyToChatter($feed.feedId__c, "Now playing '#{currentSong}'")
      end
    end
    # -----------------------------------
    # Like Song
    # -----------------------------------
    if readFromArduino.upcase=="LIKE"
      Debug.log "Do Like"
      # Send Like To Chatter
      if ($dbcom.client)
       $dbcom.likeToChatter $feed.feedId__c
      end
    end

    rescue =>ex 
      Debug.log "UNEXPECTED EXCEPTION => #{ex.class} : #{ex.message}"  
    ensure
      client.puts "Closing the connection. Bye!"
      client.close                # Disconnect from the client
    end
  end
}
end
